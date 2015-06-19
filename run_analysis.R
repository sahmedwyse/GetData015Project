#--------------------------------------------------------------------
# run_analysis.R: Class Project - Get Data and Clean Data
#                 Shafiq Ahmed, 6/19/2015.
#--------------------------------------------------------------------
# DATA REQUIREMENT:
# =================
#
# The following files and folders must be located in working directory:
#            [test]                     - folder
#               [Inertial Signal]       - folder        (optional)
#                   9 files... _test    - files         (optional)
#               X_test.txt              - file          REQUIRED    A1
#               y_test.txt              - file          REQUIRED    A2
#               subject_test.txt        - file          REQUIRED    A3
#
#            [train]                    - folder
#               [Inertial Signal]       - folder        (optional)
#                   9 files... _train   - files         (optional)
#               X_train.txt             - file          REQUIRED    B1
#               y_train.txt             - file          REQUIRED    B2
#               subject_train.txt       - file          REQUIRED    B3
# 
#            activity_labels.txt        - file          REQUIRED
#            features.txt               - file          REQUIRED
#
#            features_info.txt          - file          (optional)
#            README.txt                 - file          (optional)
#--------------------------------------------------------------------
# install.packages("dplyr")                   [one time installation]
#--------------------------------------------------------------------
run_analysis <- function()
{
    library(dplyr)

    # ---------------------------------------------------------------
    # Part 0: INVESTIGATION
    # =====================
    # This segement allows us to inspect data, and make 
    # experiments with them to understand dim, inner-relation,
    # and context of different data-frames.
    #
    # At present it is commented out, since we are done with our 
    # investigation.
    #----------------------------------------------------------------
    #     fy_test             <- "test/y_test.txt"
    #     fX_test             <- "test/X_test.txt"
    #     fsubject_test       <- "test/subject_test.txt"
    #     fbody_gyro_x_test   <- "test/Inertial Signals/body_gyro_x_test.txt"
    #     fbody_acc_x_test    <- "test/Inertial Signals/body_acc_x_test.txt"
    #     ftotal_acc_x_test   <- "test/Inertial Signals/total_acc_x_test.txt"
    #     
    #     y_test              <- read.table(fy_test)
    #     X_test              <- read.table(fX_test)
    #     subject_test        <- read.table(fsubject_test)
    #     body_gyro_x_test    <- read.table(fbody_gyro_x_test)
    #     body_acc_x_test     <- read.table(fbody_acc_x_test)
    #     total_acc_x_test    <- read.table(ftotal_acc_x_test)
    #     
    #     dy_test             <- tbl_df(y_test)
    #     dX_test             <- tbl_df(X_test)
    #     dsubject_test       <- tbl_df(subject_test)
    #     dbody_gyro_x_test   <- tbl_df(body_gyro_x_test)
    #     dbody_acc_x_test    <- tbl_df(body_acc_x_test)
    #     dtotal_acc_x_test   <- tbl_df(total_acc_x_test)
    #     
    #     print(dy_test)
    #     print(dX_test)
    #     print(dsubject_test)
    #     print(dbody_gyro_x_test)
    #     print(dbody_acc_x_test)
    #     print(dtotal_acc_x_test)

    # ---------------------------------------------------------------
    # Part 1: MERGE TEST AND TRAIN
    # ============================
    # Merges the training and the test sets to create one data set. 
    # 
    # See Data Requirement Section above, and locate A1, A2, A3 and
    # B1, B2, B3.  Each is loaded into memory as data-frame.
    # 
    # Then we construct a data-frame which looks like the following,
    #
    #      +----561----+-1--+-1--+
    #      |           |    |    |
    #      |     A1    | A2 | A3 |  test (2947 rows)
    #      |           |    |    |
    #      +-----------+----+----+
    #      |           |    |    |
    #      |           |    |    |
    #      |     B1    | B2 | B3 |  train (7352 rows)
    #      |           |    |    |
    #      |           |    |    |
    #      +-----------+----+----+
    #
    # ---------------------------------------------------------------(test)
    print("Part 1: MERGE TEST AND TRAIN...........")
    fX_test             <- "test/X_test.txt"
    fy_test             <- "test/y_test.txt"
    fsubject_test       <- "test/subject_test.txt"
    
    X_test              <- read.table(fX_test)
    y_test              <- read.table(fy_test)
    subject_test        <- read.table(fsubject_test)
    
    dX_test             <- tbl_df(X_test)
    dy_test             <- tbl_df(y_test)
    dsubject_test       <- tbl_df(subject_test)

    rm("X_test")
    rm("y_test")
    rm("subject_test")
    
    #print(dX_test)
    #print(dy_test)
    #print(dsubject_test)
    
    # Now merge columns of the data frames, building [A1 | A2 | A3]
    dtest <- cbind(dX_test, dy_test, dsubject_test)
    
    # ---------------------------------------------------------------(train)
    fX_train            <- "train/X_train.txt"
    fy_train            <- "train/y_train.txt"
    fsubject_train      <- "train/subject_train.txt"
    
    X_train             <- read.table(fX_train)
    y_train             <- read.table(fy_train)
    subject_train       <- read.table(fsubject_train)
    
    dX_train            <- tbl_df(X_train)
    dy_train            <- tbl_df(y_train)
    dsubject_train      <- tbl_df(subject_train)
    
    rm("X_train")
    rm("y_train")
    rm("subject_train")

    # Now merge columns of the data frames, building [B1 | B2 | B3]
    dtrain <- cbind(dX_train, dy_train, dsubject_train)
    
    # ------------------------------------------------------------(test + train)
    dtesttrain <- rbind(dtest, dtrain)
    
    rm("dtest")
    rm("dtrain")
    # write.table(dtesttrain, file="proj1.txt", row.name=FALSE)
    print(dim(dtesttrain))
    
    # ---------------------------------------------------------------
    # Part 2: EXTRACT mean and std COLUMNS
    # ====================================
    # Extracts only the measurements on the mean and standard deviation for 
    # each measurement. 
    # 
    # NOTE: we are keeping *mean()*  *std()*. 
    #       But we are excluding:  *meanFreq()*, etc.
    #       (66 vs 79)
    # ---------------------------------------------------------------
    print("Part 2: EXTRACT mean and std COLUMNS...")
    ffeatures       <- "features.txt"
    features        <- read.table(ffeatures)
    dfeatures       <- tbl_df(features)
    dmeanstd        <- filter(dfeatures, (grepl("mean\\(\\)", V2)>0) | (grepl("std\\(\\)", V2)>0))
    rm("features")
    
    colind          <- unlist(dmeanstd$V1)                  # Gets the index of {mean|std} columns
    colnames        <- as.character(unlist(dmeanstd$V2))    # Gets the names of {mean|std} columns
    lastpos         <- ncol(dtesttrain)
    
    colindfinal     <- c(colind, lastpos-1, lastpos)
    dtesttrainms    <- dtesttrain[, colindfinal]            # Data frame we shall work on
    
    # ---------------------------------------------------------------
    # Part 4: LABEL COLUMN NAMES
    # ==========================
    # Appropriately labels the data set with descriptive variable names.
    #
    # SPECIAL Comment: Renaming column headers before mutating a column
    # makes it easier access, and elegant.
    # ---------------------------------------------------------------
    print("Part 4: LABEL COLUMN NAMES.............")
    colnamesfinal          <- c(colnames, "Activities", "Subjects")
    colnames(dtesttrainms) <- colnamesfinal    
    
    # ---------------------------------------------------------------
    # Part 3: DESCRIPTIVE ACTIVITY NAMES
    # ==================================
    # Uses descriptive activity names to name the activities in the data set 
    #
    # We create an activity-map, i.e., a vector of
    # {"WALKING" "WALKING_UPSTAIRS" "WALKING_DOWNSTAIRS" "SITTING" "STANDING" "LAYING"}
    #
    # Then we access it with an index {1, 2, 3, 4, 5, 6}
    # That index comes from 'Activities' column of dtesttrainms,
    # which is activityvalues below.
    # ---------------------------------------------------------------
    print("Part 3: DESCRIPTIVE ACTIVITY NAMES.....")
    factivities     <- "activity_labels.txt"
    activities      <- read.table(factivities)
    dactivities     <- tbl_df(activities)
    rm("activities")
    
    activitymap <- c(as.character(arrange(dactivities, V1)$V2))
    
    activityvalues <- dtesttrainms["Activities"][, 1]
    len <- length(activityvalues)
    
    activitiesnames <- as.character(vector(length=len))     # From activityvalues to activitiesnames
    for (i in 1:len) {
        activitiesnames[i] <- activitymap[ activityvalues[i] ]  
    } 
    
    tidy1 <- mutate(dtesttrainms, Activities=activitiesnames )  # Replacing 'Activities' column
    
    #write.table(tidy1, file="proj1.txt", row.name=FALSE)
    
    # ---------------------------------------------------------------
    # Part 5: SUMMARIZE AND WRITE TO FILE
    # ===================================
    # From the data set in step 4, creates a second, independent tidy data set 
    # with the average of each variable for each activity and each subject.
    #
    # Since we need to use mean() on first 66 columns, it will be
    # extremely tedious to explicitly specify 66 avgVi=mean(Vi) {i=1,66}.
    # In this context dplyr 2.0, provides summarise_each function.
    # We used it below.
    # ---------------------------------------------------------------
    print("Part 5: SUMMARIZE AND WRITE TO FILE....")
    by_activity_subject <- group_by(tidy1, Activities, Subjects)
    tidy2 <- summarise_each(by_activity_subject, funs(mean(., na.rm = TRUE)))
    
    write.table(tidy2, file="proj2.txt", row.name=FALSE, quote=FALSE, sep=" ")
    print("All Done. Please see proj2.txt file.")
}


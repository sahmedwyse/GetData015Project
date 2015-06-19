-------------------------------------------------------------------------------
                Class project for Coursera Course GetData-015
                             Shafiq Ahmed
                               6/18/2015
                              CodeBook.md
-------------------------------------------------------------------------------
    Step 1: Information on RAW data.

        The original README.txt that came with the RAW data is still main 
        reference of information.
        
        features_info.txt is another key source.
        
        It is strongly recommened user reviews those two documents briefly.
        Below, we summarize the information in light of current task of 
        tidying the data.
        
        [test]                     - folder
           X_test.txt              - file          REQUIRED    A1
           y_test.txt              - file          REQUIRED    A2
           subject_test.txt        - file          REQUIRED    A3

        [train]                    - folder
           X_train.txt             - file          REQUIRED    B1
           y_train.txt             - file          REQUIRED    B2
           subject_train.txt       - file          REQUIRED    B3

        features.txt               - file          REQUIRED    map
        activity_labels.txt        - file          REQUIRED    map
        
        Locate A1, A2, A3 and B1, B2, B3.  Each is loaded into memory as 
        data-frame.  Then we construct a data-frame which looks like the 
        following,

             +----561----+-1*-+-1--+
             |           |    |    |
             |     A1    | A2 | A3 |  test (2947 rows)
             |           |    |    |
             +-----------+----+----+
             |           |    |    |
             |           |    |    |
             |     B1    | B2 | B3 |  train (7352 rows)
             |           |    |    |
             |           |    |    |
             +-----------+----+----+
    
    Step 2: We manipulate above data-frame (using dplyr). To begin with, it 
        looks like this big data-frame.

             +----561----+-1*-+-1--+
             |           |    |    |
             |           |    |    | 
             |           |    |    |
             |     C     |  A |  S |   10299 x 562
             |           |    |    |
             |           |    |    |
             |           |    |    |
             |           |    |    |
             +-----------+----+----+
        
        We first label the 561 columns in C, with names found in features.txt.
        The remaining two columns are named as Activities and Subjects.
        Of 561 columns in C, some (66) have the moniker *mean() and *std().
        Those are of interest to us.  We filter (pick) those 66 columns, plus 
        last two columns, and call the new dataset, tidy1.

        The index and names of the columns of interest from above big data-frame 
        are shown below. (The column names come from map found in features.txt.)
        
        #   Column ind                 Column name
        1            1           tBodyAcc-mean()-X
        2            2           tBodyAcc-mean()-Y
        3            3           tBodyAcc-mean()-Z
        4            4            tBodyAcc-std()-X
        5            5            tBodyAcc-std()-Y
        6            6            tBodyAcc-std()-Z
        7           41        tGravityAcc-mean()-X
        8           42        tGravityAcc-mean()-Y
        9           43        tGravityAcc-mean()-Z
        10          44         tGravityAcc-std()-X
        11          45         tGravityAcc-std()-Y
        12          46         tGravityAcc-std()-Z
        13          81       tBodyAccJerk-mean()-X
        14          82       tBodyAccJerk-mean()-Y
        15          83       tBodyAccJerk-mean()-Z
        16          84        tBodyAccJerk-std()-X
        17          85        tBodyAccJerk-std()-Y
        18          86        tBodyAccJerk-std()-Z
        19         121          tBodyGyro-mean()-X
        20         122          tBodyGyro-mean()-Y
        21         123          tBodyGyro-mean()-Z
        22         124           tBodyGyro-std()-X
        23         125           tBodyGyro-std()-Y
        24         126           tBodyGyro-std()-Z
        25         161      tBodyGyroJerk-mean()-X
        26         162      tBodyGyroJerk-mean()-Y
        27         163      tBodyGyroJerk-mean()-Z
        28         164       tBodyGyroJerk-std()-X
        29         165       tBodyGyroJerk-std()-Y
        30         166       tBodyGyroJerk-std()-Z
        31         201          tBodyAccMag-mean()
        32         202           tBodyAccMag-std()
        33         214       tGravityAccMag-mean()
        34         215        tGravityAccMag-std()
        35         227      tBodyAccJerkMag-mean()
        36         228       tBodyAccJerkMag-std()
        37         240         tBodyGyroMag-mean()
        38         241          tBodyGyroMag-std()
        39         253     tBodyGyroJerkMag-mean()
        40         254      tBodyGyroJerkMag-std()
        41         266           fBodyAcc-mean()-X
        42         267           fBodyAcc-mean()-Y
        43         268           fBodyAcc-mean()-Z
        44         269            fBodyAcc-std()-X
        45         270            fBodyAcc-std()-Y
        46         271            fBodyAcc-std()-Z
        47         345       fBodyAccJerk-mean()-X
        48         346       fBodyAccJerk-mean()-Y
        49         347       fBodyAccJerk-mean()-Z
        50         348        fBodyAccJerk-std()-X
        51         349        fBodyAccJerk-std()-Y
        52         350        fBodyAccJerk-std()-Z
        53         424          fBodyGyro-mean()-X
        54         425          fBodyGyro-mean()-Y
        55         426          fBodyGyro-mean()-Z
        56         427           fBodyGyro-std()-X
        57         428           fBodyGyro-std()-Y
        58         429           fBodyGyro-std()-Z
        59         503          fBodyAccMag-mean()
        60         504           fBodyAccMag-std()
        61         516  fBodyBodyAccJerkMag-mean()
        62         517   fBodyBodyAccJerkMag-std()
        63         529     fBodyBodyGyroMag-mean()
        64         530      fBodyBodyGyroMag-std()
        65         542 fBodyBodyGyroJerkMag-mean()
        66         543  fBodyBodyGyroJerkMag-std()
        67         562                  Activities
        68         563                    Subjects
        
        At this stage, tidy1 looks like this, with above column names applied.
             +--66--+-1*-+-1--+
             |      |    |    |
             |      |    |    | 
             |      |    |    |
             |  T1  |  A |  S |     10299 x 66+2
             |      |    |    |
             |      |    |    |
             |      |    |    |
             |      |    |    |
             +------+----+----+        
        And we mutate Activities column (1*), by replacing its numeric values 
        {1, 2, ..., 6) with activity names 
            WALKING
            WALKING_UPSTAIRS
            WALKING_DOWNSTAIRS
            SITTING
            STANDING
            LAYING
        
    Step 3: Now we perform summarize on tidy1, using last two columns 
        'Activities' and 'Subjects' as group pivot, and taking mean() of 
        remaining 66 columns.
        
        The resultant data frame, tidy2, is 180 x 2+66, like this:
        
             +-1--+-1--+--66--+
             |    |    |      |
             |  A |  S | Avgi |     180 x 2+66
             |    |    |      |
             +----+----+------+           
        Since, there are 6 activities, and 30 subjects, there are now total
        6x30 = 180 rows.
        
        Each column in Avgi area, is average of 
        {tBodyAcc-mean()-X, tBodyAcc-mean()-Y, ..., fBodyBodyGyroJerkMag-std()}
        
        The final tidy2 is saved in proj2.txt (in working directory).
        It has column names, and no row names. Sample appears as:
 
    ---------------------------------------------------------------------------------------------------
           Activities Subjects tBodyAcc-mean()-X tBodyAcc-mean()-Y    ...    fBodyBodyGyroJerkMag-std()
               LAYING        1         0.2215982       -0.04051395    ...                    -0.9326607
               LAYING        2         0.2813734       -0.01815874    ...                    -0.9894927
                  ...      ...               ...               ...    ...                           ...
     WALKING_UPSTAIRS       29         0.2654231       -0.02994653    ...                    -0.7564642
     WALKING_UPSTAIRS       30         0.2714156       -0.02533117    ...                    -0.7913494
    ---------------------------------------------------------------------------------------------------
 
    Step 4: Units and Interpretation
      Interpret first row, 3rd column as:
      Average value of "tBodyAcc-mean()-X" measurement for Subject 1, 
      for LAYING activity is 0.2215982.
      
      Interpret last row and last column as:
      Average value of "fBodyBodyGyroJerkMag-std()" measurement for subject 30, 
      for WALKING_UPSTAIRS activity is -0.7913494.

      Since we took average per Subject, per Activity, the unit remained the 
      same for each measurement.  Citing original CookBook, the description of
      unit is as follows:
      
      "The features selected for this database come from the accelerometer and 
      gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain 
      signals (prefix 't' to denote time) were captured at a constant rate of 
      50 Hz. Then they were filtered using a median filter and a 3rd order 
      low pass Butterworth filter with a corner frequency of 20 Hz to 
      remove noise. Similarly, the acceleration signal was then separated 
      into body and gravity acceleration signals (tBodyAcc-XYZ and 
      tGravityAcc-XYZ) using another low pass Butterworth filter with a 
      corner frequency of 0.3 Hz."
      

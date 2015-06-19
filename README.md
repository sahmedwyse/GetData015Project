-------------------------------------------------------------------------------
                Class project for Coursera Course GetData-015
                             Shafiq Ahmed
                               6/18/2015
-------------------------------------------------------------------------------
                               README.md
-------------------------------------------------------------------------------
This document describes:
    How to run the script, and 
    Tidy data generated as output.

Step 1: Working environment:
        R version 3.1.3 (2015-03-09)        [Default packages]
        dplyr_0.4.1                         [Additional packages]
        
        The tree structure of input data:
        [test]                     - folder
           [Inertial Signal]       - folder        (optional)
               9 files... _test    - files         (optional)
           X_test.txt              - file          REQUIRED    A1
           y_test.txt              - file          REQUIRED    A2
           subject_test.txt        - file          REQUIRED    A3

        [train]                    - folder
           [Inertial Signal]       - folder        (optional)
               9 files... _train   - files         (optional)
           X_train.txt             - file          REQUIRED    B1
           y_train.txt             - file          REQUIRED    B2
           subject_train.txt       - file          REQUIRED    B3

        activity_labels.txt        - file  
        features.txt               - file

        features_info.txt          - file          (optional)
        README.txt                 - file          (optional)

Place above file-structure in working environment.

Place run_analysis.R in working environment. Then execute:

> install.packages("dplyr")  # if dplyr was never installed.

Execute script:

> source("run_analysis.R")
> run_analysis()

It will give output as:

> run_analysis()
[1] "Part 1: MERGE TEST AND TRAIN..........."
[1] "Part 2: EXTRACT mean and std COLUMNS..."
[1] "Part 4: LABEL COLUMN NAMES............."
[1] "Part 3: DESCRIPTIVE ACTIVITY NAMES....."
[1] "Part 5: SUMMARIZE AND WRITE TO FILE...."
[1] "All Done. Please see proj2.txt file."

The final tidy data will be saved in proj2.txt in working directory.

Step 2:  Consult CodeBook.md for details of operation.
-------------------------------------------------------------------------------

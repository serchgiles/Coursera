# Code Book
The file [`resulting_data.txt`](https://github.com/serchgiles/Coursera/blob/master/Getting%20and%20Cleaning%20Data/Project/SCRIPT/resulting_data.txt) contains the following variables

- `subID`
    - Subject id to to distinguish every observation. Numeric value from `1` to `30`.
- `actType`
    - Label name of the activity. Is one of the following. Character value.
        - `WALKING`
        - `WALKING_UPSTAIRS`
        - `WALKING_DOWNSTAIRS`
        - `SITTING`
        - `STANDING`
        - `LAYING`
- The  rest of the variables is the average of the observations of the meand and standard desviation features-type (see [`features.txt`](https://github.com/serchgiles/Coursera/blob/master/Getting%20and%20Cleaning%20Data/Project/features.txt))  
aggregated by `subID` and `actType`.

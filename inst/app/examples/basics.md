```
#access the full dataframe loaded into ODMtools

DataValues()

#retrieve values selected in the plot (only when plotting < 100,000 points)

Selected()

#write any modifications back to the dataframe

Upsert()

#example

Selected() %>%  
  mutate(DataValue = DataValue + 10,  
    QualifierID = 106) %>%  
    Upsert()
```
```
#access the full dataframe loaded into ODMtools

DataValues()

#retrieve values selected in the plot

Selected()

#write any modifications back to the dataframe

Upsert()

#example

Selected() %>%  
  mutate(DataValue = DataValue + 10,  
    QualifierID = 106) %>%  
    Upsert()
```
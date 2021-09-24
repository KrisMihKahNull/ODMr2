```
#Access the full dataframe loaded into ODMtools

DataValues()

#Retrieve values selected in the plot

Selected()

#Write any modifications back to the dataframe

Upsert()

#Example

Selected() %>%  
  dplyr::mutate(DataValue = DataValue + 10,  
    QualifierID = 106) %>%  
    Upsert()
```
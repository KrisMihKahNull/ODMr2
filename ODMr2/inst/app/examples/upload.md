```
#remove unnessary columns and upload changes back to database

DataValues() %>%  
  filter(edited == "TRUE") %>%  
  select(-label, -edited, -index) %>%  
  odm_write()
```
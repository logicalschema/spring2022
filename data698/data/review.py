import pandas as pd

df1  = pd.read_csv('2018_DOE_Middle_School_Directory.csv')
df2  = pd.read_csv('2019_DOE_Middle_School_Directory.csv')
df3  = pd.read_csv('2020_DOE_Middle_School_Directory.csv')
df4  = pd.read_csv('2021_DOE_Middle_School_Directory.csv')

df1['year'] = 2018
df2['year'] = 2019
df3['year'] = 2020
df4['year'] = 2021


l1 = list(df1.columns.values)
l2 = list(df2.columns.values)
l3 = list(df3.columns.values)
l4 = list(df4.columns.values)


# 'district','schooldbn','printedschoolname','neighborhood','address','coursepassrate','elaprof','mathprof','surveysafety','ellprograms','languageclasses','acceleratedclasses','electiveclasses','accessibility'
# 'district','schooldbn','name','neighborhood','address','coursepassrate','elaprof','mathprof','surveysafety','ellprograms','languageclasses','acceleratedclasses','electiveclasses','activities_description','accessibility_description','other_features'


m1 = df1[['district','schooldbn','printedschoolname','neighborhood','address','coursepassrate','elaprof','mathprof','totalstudents','surveysafety','ellprograms','languageclasses','acceleratedclasses','electiveclasses','activities','accessibility', 'year']]
m2 = df2[['district','schooldbn','printedschoolname','neighborhood','address','coursepassrate','elaprof','mathprof','totalstudents','surveysafety','ellprograms','languageclasses','acceleratedclasses','electiveclasses','activities','accessibility', 'year']]
m3 = df3[['district','schooldbn','name','neighborhood','address','coursepassrate','elaprof','mathprof','totalstudents','surveysafety','ellprograms','languageclasses','acceleratedclasses','electiveclasses','activities','accessibility', 'year']]
m4 = df4[['district','schooldbn','name','neighborhood','address','coursepassrate','elaprof','mathprof','totalstudents','surveysafety','ellprograms','languageclasses','acceleratedclasses','electiveclasses','activities_description','accessibility_description', 'year']]




m1 = m1.rename(columns={"printedschoolname": "name"})
m2 = m2.rename(columns={"printedschoolname": "name"})
m4 = m4.rename(columns={"activities_description": "activities", "accessibility_description": "accessibility"})


frames = [m1, m2, m3, m4]

result = pd.concat(frames, ignore_index=True)

print(result)


result.to_csv('2018-2021_school_information.csv', index=False)
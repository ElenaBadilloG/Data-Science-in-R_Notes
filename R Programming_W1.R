### II. R PROGRAMMING ###########################################################################################################

######## W1 ####################################################################################################################

### SETTING DIRECTORIES AND CALLING FUNCTIONS

getwd() #check your current working directory

setwd("C:/Users/G13519/Documents/EB/Data Specialization/Data Sp_May 2017/II. R Programming/W 1") #change it

dir() #list the contents of your current working directory

myfunction() #not recognizable

source("myfun.R")
x<-myfunction()
z<-secondf(x,5:10)


# R has 5 basic or "atomic" classes of objects:
  # character
  # numeric (real)
  # integer
  # complex
  # logical (T/F)

### VECTORS

# Vector is the most basic R object, which can only contain objects of the same class (if you try to create a vector with objects
#of diff class, R with coerce the vector to some of the classes (to the "least common denominator class").

 # By contrast, a list can contain diff classes of objects

# By default, all real numbers are treated as numeric w/double precision. However, adding L as a suffix lets them be treated as
#integers. Infinity=Inf

# R objects usually have ATTRIBUTES: length, names, dimensions, class, other user-defined attributes (metadata). You can access
#objects' attributes with function attributes()

# Function c can be used to create vectors of objects:

x1<-c(0.1:0.10) #numeric
class(x1)
x2<-c(TRUE,FALSE) #logical
class(x2)
x3<-c(T,F) #logical
class(x3)
x4<-c("Monday", "Tuesday", "Wednesday") #character
class(x5)
x5<-c(0:10) #integer
class(x5)
x6<-c(1+0i, 1+4i) #complex
class(x6)

# But also, using the vector function you can pre-specify class and other attributes

xv<-vector("numeric", length=10)

# You can volutarily coerce a vector's objects to belong to a particular class:

x<-as.character(c(0:10))


 # If coerced to numeric or integer, FALSE=1, TRUE=0:

 # If coerced to logical, numbers greater than zero=FALSE
x<-as.logical(c(-10:10))
 #Not all coercion works: you can get NA if it doesn't make sense: character to numeric, f. ex.

### LISTS

# A vector of vectors of different class, let's say. Very useful.

xL<-list(1,"a", TRUE, 0.54, 1+5i)

### MATRICES

#A Matrix is a vector with a special attribute: dimension-> dim(n,m) function where n=rows, m=col

ma<-matrix(nrow=2,ncol=3)
ma2<-matrix(1:6,nrow=2,ncol=3) #it allocates 1:6 column-wise: fills each column until the last row until the last number

#Alternatively, I can create a matrix out of a vecdtor by simply adding dim() attribute to a vector:
v<-c(1:10)
dim(v)<-c(2,5)
v

#Or, by binding rows or columns:

a<-c(1:3)
b<-c(4:6)
c<-c(7:9)

m<-cbind(a,b,c)
m2<-rbind(a,b,c) # equiv to cbind's output transposed

### FACTORS

# Vectors of labels. Very useful: much better to label an observation with "male" or "female" than 1 or 2 which is potentially
#confusing. Divides automatically into LEVELS (the different labels the vector represents). The baseline levels is the first
#level by alphabeticval order, unless specified otherwise (with the levels= argument inside factor). Important for dummys f.ex.
#Underlying R, factors have integers assigned, though.

f<-factor(c("yes","no","no","yes"))
f

f2<-factor(c("alpha", "beta", "gamma","alpha", "beta", "gamma","alpha", "beta", "gamma"), levels=c("gamma", "alpha", "beta"))
f2

### MISSING VALUES

# NaN: undefined mathematical operations
# NA: every type of missing value
# NA can have different classes, depending the vector or list in which it's contained
# NaN is a NA but not viceversa
# Check for NA using is.na() and check for NaN using is.nan(). They will both return logical class vectors (True/False). Ex:

x<-c(2,3,4,NA,10)
xL<-list("a",3,4,NA,10, 0/0)
is.na(x)
is.nan(x)
classes<-list(class(x[4]), class(x[6])) #both are numeric, as the vector they came from
classesL<-list(class(xL[[4]]), class(xL[[6]])) #diff classes, coming from a multi-class list: NA is character, NaN is numeric

### DATA FRAMES

# Basically what a matrix is to a vector, a data frame is to a list: different classes possible among entries.
# Usually created with read.table() or read.csv, or more directly with data.frame()
# Every element (column) must have same length
# Special attribute: row.names(), very uselful. By default 1,2,.... as characters
# Can be converted into a matrix with data.matrix(). But that coerces the elements into one type.  Ex:

df<-data.frame(a=c(1:5), b=c("T", "T","F","T","F"))
df
nrow(df)
ncol(df)
row.names(df)


### DATA TYPES: 'NAMES' ATTRIBUTE

# I can assign a me to every object in R. Ex:

x<-c(1,2,3) #simple vector
names(x) #gives me NULL: no names

names(x)<-c("a","b","c")
x #call my vector, output gives me the names
class(names(x)) #names are characters

y<-list(a=1,b=2,c=3) #list
y
#or
y<-list(1,2,3)
names(y)
names(y)<-c("a","b","c")
names(y)

m<-matrix(1:4, nrow=2,ncol=2)
names(m)
dimnames(m)<-list(c("a","b"), c("c","d")) #name each row and each column (assigning name vectors in that order)
m

### READING TABULAR DATA

# read.table(), read.csv() for reading tabular data (data tables)
# readLines() for reading lines of a text file, as characters
# source () for reading in R code files: inverse of dump (f.ex. calling functions that my script need to use)
# dget() for reading in R code files that have been deparsed into text files (inverse of dput)
# load() for redaing in saved workspaces
# unserialize() for reading single R objects in binary form

# Analogous to the previous reading functions, some writing functions:

# write.csv(), write.table()
# writeLines()
# dump
# dput
# save
# serialize

## READ.TABLE FUNCTION
# arguments:

#file: route with filename to be read (required)
#header: logical (Y/N) indicating whether the file has a header line (not to be treated like the rest of the dataset)
#sep: what kind of separator is between columns: space, comma, etc. Default is space in table, comma in csv
#colClasses: vector with every column class
#nrows: number of rows in the dataset
#comment.char: character that I want R to ignore when reading. f.ex: $
#skip: number of lines to skip from the beginning. If some file's line begin with # it skips it automatically
#stringsAsFactors: logical answering should characters be read as factors? by default, YES

d<-read.table("foo.txt") #reads a and b as data in the dataset
d<-read.table("foo.txt", header=TRUE, colClasses = c("numeric", "factor")) #reads a and b as each col header, not as entries
class(d[,2]) #I specified column 2 to be factor, not numeric

#read.csv identcal to read.table except default sep is comma AND DEFAULT FOR HEADER IS true

d2<-read.table("D.txt", header=TRUE,skip=12)
d3<-read.csv("D.csv",skip=17)
d4<-read.table("D.csv", sep=",", skip=17) #identical to d3

### READING LARGE TABLES

# Reading very large tables can take time and even choke R: important to optimize (if your dataset is > than 1/2 RAM forget it)
# Read ?read.table, which contains a lot of hints
# You can make it much faster by specifying arguments, rather than keeping the default. Ex:
  # set comment.char="" if there are no commented lines in the file
  # know your system beforehand: memory available, operating system, 32/64 bit, etc. A simple rule to estimate req GB:
    # Suppose 1,500,000 rows and 120 columns of only numeric data and a 64-bit op system. Then:
      reqmem<-1500000*120*8
      reqMB<-reqmem/2^20
      reqGB<-reqMB/1000
      # + final rule of thumb: 2 x reqGB
  # specify colClasses() instaed of forcing R to go into each column. A simple way to figure out and set col classes:
      initial<-read.table("D.txt", header=TRUE,skip=12, nrows=100) #read small subset of the dataset 
      classes<-sapply(initial,class) #class() detects class
      tabAll<-read.table("D.txt", header=TRUE,skip=12,colClasses=classes)
      
 ### TEXTUAL DATA FORMATS

    dput(d2, file="dp2.R") #takes an R object and it deparses it into a separate text file
      dg2<-dget("dp2.R")   #inverse, takes a deparsed text file reads it back into R (under a pre-specified structure)
      dg2
   
 # dump is like dget but can be used on multiple R objects (dget just one). Its input is a character vecto containing the names
 # of the objects you want to deparse into a file
      
      dump(c("d2","d3"), file="DR.R")
      rm(d2,d3)
      source("DR.R") #re-read both objects into R and reconstructs them
      d2
      d3

 ### CONNECTIONS: INTERFACES TO THE OUTSIDE WORLD
  # Some of the main functions that allow us to connect to locations, objects, outside of R:
       # file(): any uncompressed file like .txt, .xlsx, .csv
       # url(): websites
       # gzfile(): compressed files (.gz)
       # bzfile(): compressed files (.bz)
      
  # Sometimes file() might be redundant. For instance, if I will read the whole file into R anyway. However, if I do not want to
  # read the whole file but just a subset of it, it's useful to open the connection and just get what I need.

  # The above is extremely useful when wanting to get data from websites. Ex:
    
      ad<-"http://www.globalhealthnow.org/index.php/topics/climate-change"
      con<-url(ad)
      x<-readLines(con)
      head(x) #html lines, as expected
 
      
 
      
     file("D.csv")



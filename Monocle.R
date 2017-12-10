library(monocle)
library(reshape)
library(Matrix)
library(dplyr)

myData <- utils::read.table("Data/FilteredCell_Aging_AllReads_06Sept2017.csv", 
                                    row.names = 1, sep = ',', header = T, check.names = F)
## Extract name from column name
myTimeString = regmatches(colnames(myData),regexpr("[0-9A-Za-z]+",colnames(myData)))

## Define the parametes for ages in sample
## mySampleAges is the age of each sample, as factor
## myTimePeriod is the period of time used: hour/day/month/year/mpf
## myTimePoints are the discrete time points present in the samples
mySampleAges = as.factor(as.numeric(regmatches(myTimeString,regexpr("[0-9]+",myTimeString))))
myTimePeriod = regmatches(myTimeString[1],regexpr("[A-Za-z]+",myTimeString[1]))
myTimePoints = levels(mySampleAges)
print(paste("The data contains",ncol(myData),"samples from",
            nlevels(mySampleAges),"time points, from", 
            min(as.numeric(myTimePoints)),myTimePeriod,"to",
            max(as.numeric(myTimePoints)),myTimePeriod))


## We will set the stage of each discrete time point. We have seven time points: 1, 3, 4, 6, 10, 12, 14 mpf
## The first one (1 mpf) is set to 'Juvenile', next three (3, 4, 6 mpf) to 'Young', and the last three (10, 12, 14 mpf) to 'Old'
Age.labels <- c("Juvenile", rep("Young", 3), rep("Old", 3))

## We redo the old ages to new stages
## Since this command throws a warning about repeating levels, we will temporally suppress them.
suppressWarnings(Sample.age.conditions <- factor(factor(mySampleAges, labels = Age.labels)))

## And extract the number of conditions (stages). This helps with classification.
myConditions <- factor(Sample.age.conditions, labels = 0:(nlevels(Sample.age.conditions)-1))
myLevels = levels(myConditions)

cat(paste("The data contains ",nlevels(myConditions), "classification stages of: "), paste(myTimePoints, myTimePeriod, ":", Age.labels), sep = "\n")


## Monocle Ordering
SC_sample_sheet <- as.data.frame(Sample.age.conditions, row.names = colnames(myData))
pd <- new("AnnotatedDataFrame", data = SC_sample_sheet)
SC <- newCellDataSet(as.matrix(myData), 
                     phenoData = pd, expressionFamily = negbinomial())

## We will not further filter any cells since they are already pre-filtered

## Find genes for ordering
SC <- estimateSizeFactors(SC)
SC <- estimateDispersions(SC)
disp_table <- dispersionTable(SC)
ordering_genes <- subset(disp_table,
                         mean_expression >= 0.5 &
                           dispersion_empirical >= 2 * dispersion_fit)$gene_id
SC <- setOrderingFilter(SC, ordering_genes)
plot_ordering_genes(SC)

#Ordering
SC <- reduceDimension(SC, max_components=2)
SC <- orderCells(SC, reverse=T)
plot_cell_trajectory(SC, color_by="Sample.age.conditions")

pdf(file = "Pseudotime.pdf", width = 5, height = 5, useDingbats = F)
plot_cell_trajectory(SC, color_by="Sample.age.conditions")
dev.off()

library(bibliometrix)
library(tidyverse)

# Load Files
file = "BSxAI/biorisk.csv"

# First Dataframe
M <- convert2df(file,dbsource = "dimensions",format = "csv")

# # Basic results
results <- biblioAnalysis(M, sep=";")
summary(results)

## Network Analysis - Collaboration by author. For author p and q, size of edge is number of papers p and q have written together.
AuCollabMatrix <- biblioNetwork(M, analysis = "collaboration", network = "authors", short=TRUE)
netCollab=networkPlot(AuCollabMatrix, 
                   normalize=NULL, #similarity index method set to default.
                   n=NULL, # plot all vertices
                   Title = "Collaboration Network - by author (min 2 collaborations)", 
                   type = "auto", 
                   remove.multiple=TRUE, 
                   label=TRUE,
                   labelsize=.5,
                   edgesize = 1, 
                   edges.min = 10,
                   remove.isolates = TRUE, 
                   halo=TRUE,
                   cluster="walktrap",
                   community.repulsion = .1,
                   size.cex = FALSE,
                   curved = TRUE,
                   noloops = TRUE)

## Network Analysis - Co-citation by reference. For p-q link, edge size is how many works cite both p and q
AuCoCMatrix <- biblioNetwork(M, analysis = "co-citation", network = "references", short=FALSE)
netCoC=networkPlot(AuCoCMatrix, 
                normalize=NULL, #similarity index method set to default.
                n=NULL, # plot all vertices
                Title = "Co-citation Network - by reference (n=6, i.e. ~10% of corpus)", 
                type = "auto", 
                size=5, 
                remove.multiple=TRUE, 
                label=TRUE,
                labelsize=1,
                edgesize = 1, 
                edges.min = 6,
                remove.isolates = TRUE, 
                halo=FALSE,
                cluster="walktrap",
                community.repulsion = .1,
                size.cex = FALSE,
                curved = TRUE,
                noloops = TRUE
)
# # Network Analysis - Coupling by references. For DOCUMENT p q, weight of edge is how many references are in common between p and q.
RefMatrix <- biblioNetwork(M, analysis = "coupling", network = "references", short = FALSE)
netref=networkPlot(RefMatrix, 
                normalize=NULL, #similarity index method set to default.
                n = NULL, # plot all vertices
                Title = "Coupling Network - by Reference (min = 5)", 
                type = "auto", 
                remove.multiple=TRUE, 
                label=TRUE,
                labelsize=0.7,
                edgesize = 1, 
                edges.min = 5,
                remove.isolates = TRUE, 
                halo=FALSE,
                cluster="walktrap",
                community.repulsion = .1,
                size.cex = FALSE,
                curved = TRUE,
                noloops = TRUE
)


# # Network Analysis - Coupling by author. For authors p and q, weight of edge is how many citations are in common between p and q.
AuMatrix <- biblioNetwork(M, analysis = "coupling", network = "authors", short=TRUE)
net=networkPlot(AuMatrix, 
                normalize=NULL, #similarity index method set to default.
                n = NULL, # plot all vertices
                Title = "Coupling Network - Authors (min=20)", 
                type = "auto", 
                remove.multiple=FALSE, 
                label=TRUE,
                labelsize=0.5,
                edgesize = 1, 
                edges.min = 15,
                remove.isolates = TRUE, 
                halo=FALSE,
                cluster="walktrap",
                community.repulsion = .3,
                size.cex = FALSE,
                curved = TRUE,
                noloops = TRUE
                )
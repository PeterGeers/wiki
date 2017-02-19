suppressMessages(library("tm"))
suppressMessages(library("SnowballC"))
suppressMessages(library("wordcloud"))
suppressMessages(library("RColorBrewer"))
suppressMessages(library("memoise"))
suppressMessages(require("googlesheets"))
suppressMessages(require(DT))


##suppressMessages(ss <- gs_title("Wikilinks"))
suppressMessages(ss <- gs_key("1Qp594CTLn6snMLHGmdXLYAwB7u0iveQwArpHZbe1Axo"))
suppressMessages(data <- gs_read_csv(ss, "Formulierreacties 2"))

# list to select from
myTags <- list( "All"=".", "AWS" = "aws", "Cloud" = "cloud","Gartner"="gartner","portfolio"="portfolio", "Security"= "security", "Trends" = "trends")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(xSelect)
{
    # xSelect <- selection
    myText <- data$tags
    # Remove all spaces from tags
    myText <- gsub(" ","", myText)
    keep <- grepl(xSelect, myText, ignore.case = TRUE)
    myText <- myText[keep]
    # Convert tags to list
    docs <- Corpus(VectorSource(myText))
    
    toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
    docs <- tm_map(docs, toSpace, "/")
    docs <- tm_map(docs, toSpace, "@")
    docs <- tm_map(docs, toSpace, "\\|")
    docs <- tm_map(docs, toSpace, '"')
    docs <- tm_map(docs, toSpace, ',')
    # Convert the text to lower case
    docs <- tm_map(docs, content_transformer(tolower))
    # Remove numbers
    docs <- tm_map(docs, removeNumbers)
    # Remove english common stopwords
    docs <- tm_map(docs, removeWords, stopwords("english"))
    # Remove your own stop word
    # specify your stopwords as a character vector
    docs <- tm_map(docs, removeWords, c("ericsson", "quadrant")) 
    # Remove punctuations
    docs <- tm_map(docs, removePunctuation)
    # Eliminate extra white spaces [Already done before]
    # docs <- tm_map(docs, stripWhitespace)
    # Text stemming Not Using non-readable
    # docs <- tm_map(docs, stemDocument)
    
    myDTM <- TermDocumentMatrix(docs, control = list(minWordLength = 1))
    
    m <- as.matrix(myDTM)
    v <- sort(rowSums(m),decreasing=TRUE)
    d <- data.frame(word = names(v),freq=v)
    ## myTags <- list(d$word[1:50])
    ## return(d)
    })

getWiki <- memoise(function(x) {
    # xSelect <- selection
    wiki <- data
    # Remove all spaces from tags
    wiki$tags <- gsub(" ","", wiki$tags)
    wiki$tags <- gsub(",",", ", wiki$tags)
    keep <- grepl(x, wiki$tags, ignore.case = TRUE)
    wiki <- wiki[keep,]
    wiki$url <- paste('<a href="',wiki$url,'" target="_blank">', wiki$shortdescription, '</a>')
    wiki <- subset(wiki, select = c(url, tags, datum))
    names(wiki) <- c('Description__________________________', 'Tags____________', 'Date')
    return(wiki)
    })






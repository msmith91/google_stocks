#pulls from csv table of stock prices
#to use, run Rscript ticker_graph.R "NLSN" (for nlsn graph)
#outputs graph to location designated

#get command line arguments
args <- commandArgs(TRUE)

#function for pulling mysql output and putting into graph on server
price_graph <- function(ticker){
stocks <- read.csv(file="stocks_py_date.csv")
stock <- stocks[grep(ticker,stocks$Stock),]
for_graph <- data.frame(Stock=stock$Stock, Price=stock$Price)
cat('"','/var/www/projects/stocks/images/',ticker,'.jpeg','"',sep="");
jpeg(paste('/var/www/projects/stocks/images/',ticker,'.jpeg',sep=''))
plot(row.names(for_graph),for_graph$Price,main=ticker,type="l")
dev.off()
}

#run command
price_graph(args[1])

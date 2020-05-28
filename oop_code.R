data <- read.csv("data/MIE.csv")

make_LD <- function(object){
    structure(object, class = "LongitudinalData")
}

print.LongitudinalData <- function(object){
    cat("Longitudinal dataset with", length(unique(object$id)), "subjects")   
}

subject <- function(object) UseMethod("subject")

subject <- function(object, id_num){
    structure(lapply(object, "[", object$id == id_num), class = "subject")
}

print.subject <- function(object){
    if (length(object$id)==0) {
        NULL
    }else{
        cat("Subject ID:", object$id[1])
    }
}

visit <- function(object, vis_num) UseMethod("visit")

visit.subject <- function(object, vis_num){
    structure(lapply(object, "[", object$visit == vis_num), class = "subject")
}

room <- function(object, room_name) UseMethod("room")

room.subject <- function(object, room_name){
    structure(lapply(object, "[", object$room == room_name), class = "room")
}

print.room <- function(object){
    cat("ID:",object$id[1],"\nVisit:",object$visit[1],"\nRoom:",levels(object$room)[object$room[1]])
}

summary.room <- function(object){
    min = min(object$value, na.rm = TRUE)
    max = max(object$value, na.rm = TRUE)
    first_q = quantile(object$value, probs = .25, na.rm = TRUE)
    third_q = quantile(object$value, probs = .75, na.rm = TRUE)
    mean = mean(object$value, na.rm = TRUE)
    median = median(object$value, na.rm = TRUE)
    structure(list(id = object$id, min = min, max = max, first_q = unname(first_q), 
                   third_q = unname(third_q), mean = mean, 
                   median = median), class = "summary_room")
}

print.summary_room <- function(object){
    object = as.array(object)
    cat("ID:",object$id[1],"\n")
    
    df = data.frame(object$min,object$first_q,object$median,
                    object$mean,object$third_q,object$max)
    colnames(df) = c("Min.","1st Qu.","Median","Mean","3rd Qu.","Max.")
    print(df)
}

summary <- function(object) UseMethod("summary")

summary.subject <- function(object){
    structure(lapply(object, split, f = object$visit), class = "summary_subject")
}

print.summary_subject <- function(object){
    cat("ID:",object$id$`0`[1],"\n")
    object = list(
        `0` = split(object$value$`0`, object$room$`0`),
        `1` = split(object$value$`1`, object$room$`1`),
        `2` = split(object$value$`2`, object$room$`2`)
    )
    object = sapply(object, function(x) sapply(x, mean, na.rm = TRUE))
    object = t(object[rowSums(is.na(object)) != ncol(object),])
    as.data.frame(object)
    rowns = rownames(object)
    rownames(object) = NULL
    colns = colnames(object)
    colnames(object) = NULL
    object = cbind(as.numeric(rowns),object)
    colnames(object) = c("visit", colns)
    print(object)
}

#####################################
x <- make_LD(data)
print(class(x))
print(x)

## Subject 10 doesn't exist
out <- subject(x, 10)
print(out)

out <- subject(x, 14)
print(out)

out <- subject(x, 54) %>% summary
print(out)

out <- subject(x, 14) %>% summary
print(out)

out <- subject(x, 44) %>% visit(0) %>% room("bedroom")
print(out)

## Show a summary of the pollutant values
out <- subject(x, 44) %>% visit(0) %>% room("bedroom") %>% summary
print(out)

out <- subject(x, 44) %>% visit(1) %>% room("living room") %>% summary
print(out)
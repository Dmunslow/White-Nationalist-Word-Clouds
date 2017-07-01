###########################################
##### White Nationalist Follower Data #####
###########################################

setwd("E:/Projects/White Nationalists/White-Nationalist-Word-Clouds")

library(rtweet)

############## Richard Spencer #################################################

## Check profile info
RSpencer <- lookup_users("RichardBSpencer")


## Get follower IDS

RS_followerIDs <- get_followers(RSpencer$user_id)


### Get profile info 

### Info requests are rate-limited to 18000 per request
### Need to create loop to pull data on rate limit and compile into dataframe


##### 1. Set up empty dataframe

# Get number of columns for user data DF and create df with 0 rows
num_columns <- ncol(RSpencer)
RS_followers <- data.frame(matrix(nrow = 0, ncol = num_columns))

# Assign column names to empty DF
colnames(RS_followers) <- colnames(RSpencer)

#### 2. Calculate Loop iterations

# initialize loop variables - use integer division
info_interations <- (RSpencer$followers_count %/% 18000) + 1
info_index = 1


for(i in 1:info_interations){
    
    followerdata_temp <- lookup_users(RS_followerIDs[info_index:(i*18000),])
    
    info_index = info_index + 18000
    
    # add data to basshead data frame
    RS_followers <- rbind(RS_followers, followerdata_temp)
    
    # Remove uneeded DF
    rm(followerdata_temp)
    
    # Check rate limit
    currentRL <- rate_limit(twitter_token)

    # sleep until reset if RL is hit
    if(currentRL$remaining[36] < 180){
        
        # Pause R until ratelimit reset
        Sys.sleep(60* (as.integer(currentRL$reset[36])) + 1)
    }
    
}

## Write data to csv

write.csv(RS_followers, "./Richard_Spencer_Follower_Data.csv", row.names = F)



################### David Duke #################################################

## Check profile info
DDuke <- lookup_users("DrDavidDuke")


## Get follower IDS

DD_followerIDs <- get_followers(DDuke$user_id)


### Get profile info 

### Info requests are rate-limited to 18000 per request
### Need to create loop to pull data on rate limit and compile into dataframe


##### 1. Set up empty dataframe

# Get number of columns for user data DF and create df with 0 rows
num_columns <- ncol(DDuke)
DD_followers <- data.frame(matrix(nrow = 0, ncol = num_columns))

# Assign column names to empty DF
colnames(DD_followers) <- colnames(DDuke)

#### 2. Calculate Loop iterations

# initialize loop variables - use integer division
info_interations <- (DDuke$followers_count %/% 18000) + 1
info_index = 1


for(i in 1:info_interations){
    
    followerdata_temp <- lookup_users(DD_followerIDs[info_index:(i*18000),])
    
    info_index = info_index + 18000
    
    # add data to basshead data frame
    DD_followers <- rbind(DD_followers, followerdata_temp)
    
    # Remove uneeded DF
    rm(followerdata_temp)
    
    # Check rate limit
    currentRL <- rate_limit(twitter_token)
    
    # sleep until reset if RL is hit
    if(currentRL$remaining[36] < 180){
        
        # Pause R until ratelimit reset
        Sys.sleep(60* (as.integer(currentRL$reset[36])) + 1)
    }
    
}

## Write data to csv

write.csv(DD_followers, "./David_Duke_Follower_Data.csv", row.names = F)


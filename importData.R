
####### Mail Pre-processing & Loading #######

# Decoding quoted-printable data.
decode_quoted <- function(data) {
    qp_before <- c("=00", "=01", "=02", "=03", "=04", "=05", "=06", "=07", "=08", "=09", "=0A",
               "=0B", "=0C", "=0D", "=0E", "=0F", "=10", "=11", "=12", "=13", "=14", "=15",
               "=16", "=17", "=18", "=19", "=1A", "=1B", "=1C", "=1D", "=1E", "=1F", "=20",
               "=21", "=22", "=23", "=24", "=25", "=26", "=27", "=28", "=29", "=2A", "=2B",
               "=2C", "=2D", "=2E", "=2F", "=30", "=31", "=32", "=33", "=34", "=35", "=36",
               "=37", "=38", "=39", "=3A", "=3B", "=3C", "=3D", "=3E", "=3F", "=40", "=41",
               "=42", "=43", "=44", "=45", "=46", "=47", "=48", "=49", "=4A", "=4B", "=4C",
               "=4D", "=4E", "=4F", "=50", "=51", "=52", "=53", "=54", "=55", "=56", "=57",
               "=58", "=59", "=5A", "=5B", "=5C", "=5D", "=5E", "=5F", "=60", "=61", "=62", 
               "=63", "=64", "=65", "=66", "=67", "=68", "=69", "=6A", "=6B", "=6C", "=6D", 
               "=6E", "=6F", "=70", "=71", "=72", "=73", "=74", "=75", "=76", "=77", "=78",
               "=79", "=7A", "=7B", "=7C", "=7D", "=7E", "=7F", "=80", "=81", "=82", "=83", 
               "=84", "=85", "=86", "=87", "=88", "=89", "=8A", "=8B", "=8C", "=8D", "=8E", 
               "=8F", "=90", "=91", "=92", "=93", "=94", "=95", "=96", "=97", "=98", "=99", 
               "=9A", "=9B", "=9C", "=9D", "=9E", "=9F", "=A0", "=A1", "=A2", "=A3", "=A4", 
               "=A5", "=A6", "=A7", "=A8", "=A9", "=AA", "=AB", "=AC", "=AD", "=AE", "=AF",
               "=B0", "=B1", "=B2", "=B3", "=B4", "=B5", "=B6", "=B7", "=B8", "=B9", "=BA", 
               "=BB", "=BC", "=BD", "=BE", "=BF", "=C0", "=C1", "=C2", "=C3", "=C4", "=C5",
               "=C6", "=C7", "=C8", "=C9", "=CA", "=CB", "=CC", "=CD", "=CE", "=CF", "=D0",
               "=D1", "=D2", "=D3", "=D4", "=D5", "=D6", "=D7", "=D8", "=D9", "=DA", "=DB", 
               "=DC", "=DD", "=DE", "=DF", "=E0", "=E1", "=E2", "=E3", "=E4", "=E5", "=E6", 
               "=E7", "=E8", "=E9", "=EA", "=EB", "=EC", "=ED", "=EE", "=EF", "=F0", "=F1", 
               "=F2", "=F3", "=F4", "=F5", "=F6", "=F7", "=F8", "=F9", "=FA", "=FB", "=FC", 
               "=FD", "=FE", "=FF", "=\r\n")
    qp_after <- c("", "\001", "\002", "\003", "\004", "\005", "\006", "\a", "\b", "\t", "\n", 
              "\v", "\f", "\r", "\016", "\017", "\020", "\021", "\022", "\023", "\024", 
              "\025", "\026", "\027", "\030", "\031", "\032", "\033", "\034", "\035", 
              "\036", "\037", " ", "!", "\"", "#", "$", "%", "&", "'", "(", ")", "*", "+",
              ",", "-", ".", "/", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", ":", 
              ";", "<", "=", ">", "?", "@", "A", "B", "C", "D", "E", "F", "G", "H", "I", 
              "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", 
              "Y", "Z", "[", "\\", "]", "^", "_", "`", "a", "b", "c", "d", "e", "f", "g",
              "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", 
              "w", "x", "y", "z", "{", "|", "}", "~", "\177", "\x80", "\x81", "\x82", 
              "\x83", "\x84", "\x85", "\x86", "\x87", "\x88", "\x89", "\x8a", "\x8b", 
              "\x8c", "\x8d", "\x8e", "\x8f", "\x90", "\x91", "\x92", "\x93", "\x94", 
              "\x95", "\x96", "\x97", "\x98", "\x99", "\x9a", "\x9b", "\x9c", "\x9d", 
              "\x9e", "\x9f", "\xa0", "\xa1", "\xa2", "\xa3", "\xa4", "\xa5", "\xa6", 
              "\xa7", "\xa8", "\xa9", "\xaa", "\xab", "\xac", "\xad", "\xae", "\xaf", 
              "\xb0", "\xb1", "\xb2", "\xb3", "\xb4", "\xb5", "\xb6", "\xb7", "\xb8", 
              "\xb9", "\xba", "\xbb", "\xbc", "\xbd", "\xbe", "\xbf", "\xc0", "\xc1", 
              "\xc2", "\xc3", "\xc4", "\xc5", "\xc6", "\xc7", "\xc8", "\xc9", "\xca", 
              "\xcb", "\xcc", "\xcd", "\xce", "\xcf", "\xd0", "\xd1", "\xd2", "\xd3", 
              "\xd4", "\xd5", "\xd6", "\xd7", "\xd8", "\xd9", "\xda", "\xdb", "\xdc", 
              "\xdd", "\xde", "\xdf", "\xe0", "\xe1", "\xe2", "\xe3", "\xe4", "\xe5", 
              "\xe6", "\xe7", "\xe8", "\xe9", "\xea", "\xeb", "\xec", "\xed", "\xee", 
              "\xef", "\xf0", "\xf1", "\xf2", "\xf3", "\xf4", "\xf5", "\xf6", "\xf7", 
              "\xf8", "\xf9", "\xfa", "\xfb", "\xfc", "\xfd", "\xfe", "\xff", "")
    decoded <- stri_replace_all_fixed(data,qp_before,qp_after,vectorize_all=FALSE)
    return(decoded)
}

# Converting HTML to Text
html2text <- function(html) {
    return(xpathSApply(htmlParse(html, asText=TRUE),"//text()[not(ancestor::script)][not(ancestor::style)][not(ancestor::noscript)][not(ancestor::form)]", xmlValue))
}

# Parsing raw emails into simple text.
readMails <- function(folder) {

    # List mails in data folder.
    files <- dir(folder)
    
    # Prepare output vector.
    text <- character(0)
    
    for (i in 1:length(files)) {
    
        # Read mail and remove invalid characters.
        mail <- iconv(readLines(paste0(folder,'/',files[i]),encoding='UTF-8',warn=FALSE),'UTF-8','UTF-8',sub='')
        
        # Search end of header.
        j <- which(mail=='')[1]
        head <- mail[1:(j-1)]
        body <- mail[(j+1):length(mail)]
        
        # Format multi-lines in header.
        m <- which(grepl("^\\s.*$",head)) # Continuing lines.
        s <- setdiff(m-1,m) # Starts of multi-lines.
        e <- setdiff(m+1,m)-1 # Ends of multi-lines.
        if (length(s)>0) for (j in 1:length(s)) {
            head[s[j]] <- paste(head[s[j]:e[j]],collapse='') # Join multi-lines.
        }
        head <- head[-m] # Remove continuing lines.
        
        # Get subject.
        j = which(substring(head,1,7)=='Subject')
        if (length(j)==0) {
            subject = '' # Set empty subject if none is given.
        } else {
            # Extract subject.
            subject = trimws(substring(head[j],10)) # Get part after "Subject: " and remove spaces.
        }
        
        # Get content-type from header.
        j <- which(substring(head,1,12)=='Content-Type')
        if (length(j)==0) {
            type <- 'text/plain' # Set default if none is given.
        } else {
            # Extract content type.
            type <- substring(head[j],15) # Get part after "Content-Type: "
            type <- trimws(strsplit(type,';')[[1]]) # Split on ";" and remove spaces.
            type <- tolower(type[1]) # First part is content type.
        }
        type <- strsplit(type,'/')[[1]] # Split content type on "/".
        
        # Handle multipart mails.
        if (type[1]=='multipart') {
            
            # Find text part.
            j <- which(grepl("^content-type:\\s+text/plain.*$",tolower(body))) # Find text/plain part.
            if (length(j)>0) {
                type <- c('text','plain')
            } else {
                j <- which(grepl("^content-type:\\s+text/html.*$",tolower(body))) # Find text/html part.
                if (length(j)>0) {
                    type <- c('text','html')
                } else stop(paste('No text part in:',files[i]))
            }
            j <- min(j)
            
            # Find boundary of part.
            boundary <- body[j-1]
            k <- setdiff(pmax(j,which(body==boundary | body==paste0(boundary,'--'))),j)
            if (length(k)==0) k = length(body)
            k <- min(k)
            body <- body[j:(k-1)] # Limit to text part.
            
            # Find encoding.
            j <- which(grepl('^Content-Transfer-Encoding.*$',body))
            if (length(j)==0) {
                encoding <- 'binary' # Set default encoding.
            } else {
                encoding <- tolower(trimws(substring(body[j],28)))
            }
            
            # Remove multipart header.
            j <- min(which(body==''))
            body <- body[(j+1):length(body)]
        }
        else {
            
            # Find encoding.
            j <- which(grepl('^Content-Transfer-Encoding.*$',head))
            if (length(j)>1) print(files[i])
            if (length(j)==0) {
                encoding <- 'binary' # Set default encoding.
            } else {
                encoding <- tolower(trimws(substring(head[j],28)))
            }
        }
        
        # Decode content
        if (encoding=='base64') {
            body <- rawToChar(base64decode(body))
        } else if (encoding=='quoted-printable') {
            body <- decode_quoted(body)
        }
        
        # Remove HTML syntax
        if (type[2]=='html') {
            body <- html2text(body)
        }
        
        # Tidy up content
        body <- paste(body,collapse='\n') # All on one line
        body <- paste0(subject,'\n',body) # Add subject
        body <- gsub('\\s+',' ',body) # Trim whitespaces
        
        # Add to dataset
        text <- c(text,body)
    }
    
    # Return dataset.
    mails = list(id=files,text=text)
    return(mails)
}

# Load dataset.
mails <- readMails('./CSDMC2010_SPAM/CSDMC2010_SPAM/TRAINING')
mails$id <- as.numeric(substring(mails$id,7,11))

# Load labels
lines <- readLines('./CSDMC2010_SPAM/CSDMC2010_SPAM/SPAMTrain.label')
lines <- strsplit(lines,' ')
label <- !as.logical(as.numeric(sapply(lines,function(x)x[1])))
id <- as.numeric(substring(sapply(lines,function(x)x[2]),7,11))
if (!all(1:length(id)==id+1)) {
    stop('Labels not sorted.') # Make sure labels are sorted.
}

# Add labels and convert to dataframe.
mails <- c(mails,list(spam=label[mails$id+1]))
mails <- as.data.frame(mails)

library(RDCOMClient)

sendRMail <- function(rmTo, rmCc = "", rmSubject, rmBody, 
                      rmFilePath = "", rmDisc = TRUE) {
  
  disclaimer <- paste0("\n\n", "--------------------------","\n",
                      "Disclaimer to be added if needed")

  OutApp <- COMCreate("Outlook.Application")
  
  ## create an email 
  outMail = OutApp$CreateItem(0)
  
  ## configure  email parameter 
  outMail[["To"]] = rmTo
  outMail[["Cc"]] = rmCc
  outMail[["subject"]] = rmSubject
  outMail[["HTMLBody"]] = paste0(rmBody, ifelse(rmDisc, 
                                                gsub("\n", "<br>", disclaimer), ""))
  if (length(rmFilePath) >= 1) { 
    for(attach in rmFilePath) {
      if(attach == "") next
      outMail[["Attachments"]]$Add(attach)
    }
  }
  
  ## send it                     
  outMail$Send()
  return("Mail sent")
}

import argparse, csv, hashlib, os, shutil

def mover(inCSV, outCSV, nutchDumpPath):    

    with open(outCSV, "wb") as outF:
        writer = csv.writer(outF)
        writer.writerow(["onionDomain", "onionAdURL", "FinalDumpPath"]) #"onionAdHashedFilePath"
                
        with open(inCSV, "rb") as inF:        
            reader = csv.reader(inF, delimiter=",")
            for row in reader:

                domain = row[1].strip()
                URL = row[3].strip()
                path = row[4].strip()
                record = [domain, URL]
                
                hashedAdURL = hashlib.sha256(URL).hexdigest().upper()

                #change filename inline to hashedAdURL to persist deDup
                new_filename = path.split("/")[0] + "/" + hashedAdURL
                try:
                    os.rename(path, new_filename)  #os.system("mv {0} {1}".format(path, new_filename))
                except:
                    continue
                #record.append(new_filename)

                #construct Dump filepath   #onion/swehackmzys2gpmb/www
                finalDumpPath = nutchDumpPath.rstrip("/") + "/" + "/".join(reversed(domain.split("."))) 
                if not os.path.exists(finalDumpPath):                    
                    os.makedirs(finalDumpPath)
                                    
                shutil.move(new_filename, finalDumpPath + "/" + hashedAdURL)                
                record.append(finalDumpPath + "/" + hashedAdURL)

                #pending files to be indexed using parser-indexer => feed darkDumpPoster the CSV file generated
                #send PR to update no Page Title in DarkDumpPoster

                writer.writerow(record)


if __name__ == "__main__":

    parser = argparse.ArgumentParser('dark Cron workflow')
    parser.add_argument('--inCSV', required=True)
    parser.add_argument('--outCSV', required=True)
    parser.add_argument('--nutchDumpPath', required=True, help='absolute path to dump Dir')
    args = parser.parse_args()

    if args.inCSV and args.outCSV and args.nutchDumpPath: 
        mover(args.inCSV, args.outCSV, args.nutchDumpPath)
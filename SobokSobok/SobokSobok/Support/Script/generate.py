import os
import sys
import urllib
import importlib
import csv

reload(sys)
sys.setdefaultencoding('utf-8')

# Google spreadsheet id
gid = "1ENCtjYV1b7BTVCDLzlsBHBYL7fa9aVTQl62BCe7BLhk/edit#gid=0"

# Execute function
def execute():
    downloadPath = sys.argv[1]
    
    try:
        CSVFile = exportCSVFromSheet(gid)
        dataSource = getDataFromCSV(downloadPath, CSVFile)
        for string in dataSource.items():
            writeDataSource(string[0], string[1], downloadPath)

    except Exception as e:
        print(":::::::::::::ERROR:::::::::::::")
        print(e)

# Export CSV file from google spreadsheet
def exportCSVFromSheet(gid, downloadPath=None):
    resource = gid.split('/')[0]

    if downloadPath is None:
        downloadPath = os.path.abspath(os.path.dirname(__file__))

    filename = os.path.join(downloadPath, '%s.csv' % (resource))
    url = 'https://docs.google.com/spreadsheet/ccc?key=%s&output=csv' % (resource)
    urllib.urlretrieve(url, filename)

    return filename

# Get data from CSV file
def getDataFromCSV(savepath, filename):
    source = open(filename, "r")
    reader = csv.reader(source)
    header = next(reader)
    next(reader)
    next(reader)
    
    categories = []
    indices = []
    dataSource = {}
    
    for category in header:
        if category == "": continue
        categories.append(category)
        dataSource[category] = []
        indices.append(header.index(category))

    for row in reader:
        for index in indices:
            key = row[index]
            value = row[index + 1]

            dict = {
                "key": key,
                "value": value
            }

            if dict["key"] != "":
                dataSource[categories[index//2]].append(dict)

    source.close()
    os.remove(filename)

    return dataSource

# Generate Swift File
def writeDataSource(filename, dataSource, savePath):
    if not os.path.exists(savePath + "/Common/NameSpace/"):
        os.makedirs(savePath + "/Common/NameSpace/")

    swiftFile = open(savePath + "/Common/NameSpace/" + filename + ".swift", "w")
    swiftFile.write("import UIKit\n\n")
    
    # Object type
    if filename == "Notification":
        swiftFile.write("public extension Notification.Name {\n")
    else:
        swiftFile.write("public enum "+ filename + " {\n")

    # Write line
    for item in dataSource:
        if filename == "Color":
            swiftFile.write("\tpublic static let " + item["key"] + " = " + "UIColor(named: \"" + item["value"] + "\")\n")
        elif filename == "Image":
            swiftFile.write("\tpublic static let " + item["key"] + " = " + "UIImage(named: \"" + item["value"] + "\")\n")
        elif filename == "Notification":
            swiftFile.write("\tpublic static let " + item["key"] + " = " + "Notification.Name(\"" + item["value"] + "\")\n")
        else: # Text, URL, UserDefaultKey
            swiftFile.write("\tpublic static let " + item["key"] + " = " + "\"" + item["value"] + "\"\n")

    swiftFile.write("}")
    swiftFile.close()

# Main function
if __name__ == '__main__':
    execute()

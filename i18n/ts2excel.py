#!/usr/bin/env python3

import argparse
import xml.etree.ElementTree as ET
import xlsxwriter

CONTEXT_COL   = 0
SORCE_COL     = 1
TRANS_COL = 2
COMMENT_COL   = 3
T_COMMENT_COL   = 4

def convert(ts_file, excel_file):
    workbook = xlsxwriter.Workbook(excel_file)


    worksheet = workbook.add_worksheet()

    header = workbook.add_format({'bold': True, 'text_wrap': True})
    source_fmt = workbook.add_format({'text_wrap': True})
    trans_fmt  = workbook.add_format({'text_wrap': True})

    worksheet.set_column(CONTEXT_COL, CONTEXT_COL, 50)
    worksheet.set_column(SORCE_COL,   SORCE_COL,   75)
    worksheet.set_column(TRANS_COL,   TRANS_COL,   75)
    worksheet.set_column(COMMENT_COL, COMMENT_COL, 50)
    worksheet.set_column(T_COMMENT_COL, T_COMMENT_COL, 50)


    worksheet.write(0, CONTEXT_COL, "Контекст",    header)
    worksheet.write(0, SORCE_COL,   "Английский",  header)
    worksheet.write(0, TRANS_COL,   "Русский",     header)
    worksheet.write(0, COMMENT_COL, "Коментарий\nразработчика", header)
    worksheet.write(0, T_COMMENT_COL, "Коментарий\nпереводчика",  header)

    tree = ET.parse(ts_file)



    root = tree.getroot()

    row = 1
    for c in tree.findall('context'):
        context = c.find("name").text
        #worksheet.write(row, CONTEXT_COL, context)
        #row += 1

        for message in c.findall('message'):
            source      = message.find("source").text
            translation = message.find("translation").text

            xml = message.find("comment")
            comment = xml.text if xml != None else ""


            xml = message.find("translatorcomment")
            tcomment = xml.text if xml != None else ""

            #print(f'{context} : {source}')

            worksheet.write(row, CONTEXT_COL, context)
            worksheet.write(row, SORCE_COL,   source, source_fmt)
            worksheet.write(row, TRANS_COL,   translation, trans_fmt)
            worksheet.write(row, COMMENT_COL, comment)
            worksheet.write(row, T_COMMENT_COL, tcomment)

            row += 1

    workbook.close()

    # for context in root:
    #     for child in context:
    #         print(child.tag, child.attrib)

    # for event, elem in ET.iterparse(file):
    #     if event != "end":
    #         continue


    #     print("-=-=-=-=-=-=-=-=-=-")
    #     print(elem.tag, elem)

if __name__ == "__main__":
    parser = argparse.ArgumentParser(
    description = "extract lines from TS file", add_help = True)
    parser.add_argument('file', metavar='FILE', type=str, help='TS file', nargs='?', default="bravo_rus.ts")
    args = parser.parse_args()


    try:
        ts_file = args.file
        excel_file = ts_file[:-3] + ".xlsx"
        convert(ts_file, excel_file)

    except FileNotFoundError as err:
        print(err)

    except KeyboardInterrupt:
        exit(0)
import pandas as pd
from pytablewriter import MarkdownTableWriter


def main():
    path = 'dialogue_all.csv'
    df = pd.read_csv(path, sep=',')
    w = MarkdownTableWriter()
    w.from_dataframe(df)
    with open("dialogue_all.md", "w") as u:
        w.stream = u
        w.write_table()
    d = ""
    with open("dialogue_all.md", "r") as u:
        d = u.read()
        d = d.replace(" ", "")
    with open("dialogue_all.md", "w") as u:
        u.write("# 一覧表\n\n")
        u.write(d)


if __name__ == "__main__":
    main()

import pandas as pd
from pytablewriter import MarkdownTableWriter

def main():
    path = 'dialogue_all.csv'
    df = pd.read_csv(path, sep=',')
    w = MarkdownTableWriter()
    w.from_dataframe(df)
    print(w.write_table())

if __name__ == "__main__":
    main()

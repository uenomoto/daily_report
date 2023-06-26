#!/bin/bash

TEMPLATE="template.md"

# 日付を取得
YYYY=$(date "+%Y")
MM=$(date "+%m")
DD=$(date "+%d")

# 日本語の曜日を取得
DOW=$(date "+%a")


# ディレクトリが存在しなければ作成
if [ ! -d "./$YYYY$MM" ]; then
    mkdir "./$YYYY$MM"
fi

# 新しいファイルを作成
NEWFILE="./$YYYY$MM/$DD.md"
cp "$TEMPLATE" "$NEWFILE"

# 前日のファイルを見つける
PREV_DAY=$(date -v-1d "+%d")
PREV_FILE="./$YYYY$MM/$PREV_DAY.md"

# 前日のファイルが存在する場合、その中の「Total: h」を抽出
if [ -f "$PREV_FILE" ]; then
    PREV_TOTAL=$(grep -o 'Total: .*h' "$PREV_FILE")
else
    PREV_TOTAL="Total: h"
fi

# ファイルに日付を書き込む
perl -C -i -pe "s/西暦 年 月\/日(曜日)/$YYYY 年 $MM月\/$DD日($DOW)/" "$NEWFILE"
# ファイルに前日の「Total: h」を書き込む
perl -C -i -pe "s/Total: h/$PREV_TOTAL/" "$NEWFILE"

# ファイルを開く
open "$NEWFILE"

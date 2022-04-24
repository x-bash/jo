# jo

## Query

```json
{
    "classA": [
        {
            "name": "l",
            "score": 100
        },
        {
            "name": "agent-zero",
            "score": 0
        },
        {
            "name": "agent-ten",
            "score": 10
        },
    ],
    "classB": [
        {
            "name": "lb",
            "score": 100
        },
        {
            "name": "agent-zero-b",
            "score": 0
        },
        {
            "name": "agent-ten-b",
            "score": 10
        },
    ]
}
``


```bash
x jo .classA <.data.json | (
    eval "$(x jo env .awk regex=beginRegex fold=autoFold)"
    echo "$regex" "$fold"
    echo post webservice "https://x-cmd.com/$regex/$fold"
)

x jo .class* <data.json | while x jo renv .awk regex=beginRegex fold=autoFold; do
    echo "$regex" "$fold"
    echo post webservice "https://x-cmd.com/$regex/$fold"
done

x jo .class* <data.json | x jo wrenv .awk regex=beginRegex fold=autoFold -- 'echo "$regex" "$fold"\; echo post webservice "https://x-cmd.com/$regex/$fold"'


x jo .class* beginRegex autoFold <data.json | x args -n 2 'echo "$1" "$2"\; echo post webservice "https://x-cmd.com/$1/$2"'
```


```bash

global_str=
while x jo renv .awk regex=beginRegex fold=autoFold; do
    global_str="${global_str}${regex}${fold}"
done <<A
$(x jo .class* <data.json)
A

# I am wondering how must cost it is ...
global_str="$(
x jo .class* <data.json | while x jo renv .awk regex=beginRegex fold=autoFold; do
    printf "%s" "${regex}${fold}"
done
)"


# bash only

# https://unix.stackexchange.com/questions/309547/what-is-the-portable-posix-way-to-achieve-process-substitution

global_str
while x jo renv .awk regex=beginRegex fold=autoFold; do
    global_str="${global_str}${regex}${fold}"
done < <(x jo .class* <data.json)
```


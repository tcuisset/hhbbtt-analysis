import sys
from law.cli import run as cli_run

def strToArgs(str:str) -> list[str]:
    # remove backslash (hack to get around vscode sanitizing inputs)
    str = str.replace("\\", " ")
    # split by spaces then remove empty strings
    args = list(filter(None, str.split(" ")))
    if args[0] == "law":
        args.pop(0)
    args.append("--workers")
    args.append("1")
    return args

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Wrong number of arguments. Usage : python lawLauncher.py \"law run whatever --whatever\"")
        print("(don't forgert the quotes)")
        sys.exit(1)
    
    cli_run(strToArgs(sys.argv[1]))
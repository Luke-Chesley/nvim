- yazi, to do file managaement
-- leader y

| Action                        | Yazi Keybind         | Description |
|--------------------------------|----------------------|-------------|
| Open file                      | `Enter`             | Opens the selected file |
| Navigate up                    | `h` or `Backspace`  | Move to the parent directory |
| Navigate down                  | `l` or `Enter`      | Enter a directory or open a file |
| Move up in list                | `k`                 | Moves selection up |
| Move down in list              | `j`                 | Moves selection down |
| Search files                   | `/`                 | Starts fuzzy searching |
| Delete file                    | `dd`                | Moves file to trash |
| Rename file                    | `r`                 | Renames the selected file |
| Copy file                      | `yy`                | Copies selected file (yank) |
| Cut file                       | `dd`                | Cuts selected file |
| Paste file                     | `p`                 | Pastes copied/cut file |
| Select multiple files           | `Space`             | Selects/deselects a file |
| Open in default editor          | `e`                 | Opens file in `$EDITOR` |
| Toggle hidden files             | `gh`                | Shows/hides hidden files |
| Change sorting order            | `S`                 | Sorts by name, size, date, etc. |
| Open terminal in directory      | `!`                 | Opens a terminal in the current directory |
| Preview file                    | `Tab`               | Previews the selected file |
| Quit Yazi                       | `q`                 | Exits Yazi |





- lazygit
| Action               | Lazygit Keybind  | Equivalent Git Command  |
|----------------------|----------------|------------------------|
| Stage/unstage file  | `Space`         | `git add <file>`       |
| Commit changes      | `c`             | `git commit -m ""`     |
| Push changes        | `P`             | `git push`             |
| Pull changes        | `Shift + P`     | `git pull`             |
| Merge branch       | `m`             | `git merge <branch>`   |
| Fetch new changes  | `F`             | `git fetch`            |
| View commit log     | `l`             | `git log`              |
| View file diff      | `d`             | `git diff`             |



- size of the file
-- ctrl k


- create gh repo from terminal

gh repo create my-repo-name --public --source=. --remote=origin


- goto definition

Kd

- jump back to file from Kd

ctrl o


- render json in terminal 

file.txt | jq

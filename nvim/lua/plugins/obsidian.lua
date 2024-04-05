require("obsidian").setup({
    workspaces = {
        {
            name = "work",
            path = "$HOME/Documents/obsidian/work"
        },
    },
    daily_notes = {
        folder = "daily",
        date_format = "%Y-%m-%d",
        template = "daily/daily-template.md",
    },
    new_notes_location = "notes_subdir",
})

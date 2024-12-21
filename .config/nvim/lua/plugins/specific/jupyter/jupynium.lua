return  {
    "kiyoon/jupynium.nvim",
    build = "pip3 install --user .",
    lazy = true,

    event = "BufWinEnter *.ju.py",
}

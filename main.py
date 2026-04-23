import tkinter as tk
from tkinter import font as tkfont
from PIL import Image, ImageTk
import sys, os, random

WIN_W, WIN_H = 260, 310
WIN_BG    = "#c0c0c0"
TITLE_BG  = "#000080"
TITLE_FG  = "#ffffff"
BORDER_LT = "#ffffff"
BORDER_DK = "#808080"
INSET_DK  = "#404040"
ENTRY_BG  = "#ffffff"
ENTRY_FG  = "#000000"

windows      = []
closing_flag = False
PHOTO        = None
TITLE_FONT   = None
ENTRY_FONT   = None
ROOT         = None
SCR_W        = 1920
SCR_H        = 1080

def resource_path(rel):
    base = getattr(sys, '_MEIPASS', os.path.abspath("."))
    return os.path.join(base, rel)

def rand_pos():
    x = random.randint(0, max(0, SCR_W - WIN_W))
    y = random.randint(0, max(0, SCR_H - WIN_H))
    return x, y

def close_all_windows():
    global closing_flag
    closing_flag = True
    # destroy semua sekaligus lewat ROOT — nuke everything
    for w in list(windows):
        try:
            w.destroy()
        except Exception:
            pass
    windows.clear()
    closing_flag = False

def on_window_close(win):
    if closing_flag:
        return
    count = len(windows)
    try:
        windows.remove(win)
    except ValueError:
        pass
    try:
        win.destroy()
    except Exception:
        pass
    spawn_batch(count * 2, 0)

def spawn_batch(total, spawned):
    if closing_flag or spawned >= total:
        return
    BURST = 20
    for _ in range(min(BURST, total - spawned)):
        create_window()
    # update display setelah burst biar keliatan langsung
    ROOT.update_idletasks()
    ROOT.after(0, spawn_batch, total, spawned + BURST)

def create_window():
    win = tk.Toplevel(ROOT)
    win.title("jouko")
    win.resizable(False, False)
    win.configure(bg=WIN_BG)

    x, y = rand_pos()
    win.geometry(f"{WIN_W}x{WIN_H}+{x}+{y}")
    windows.append(win)

    outer = tk.Frame(win, bg=WIN_BG, bd=0)
    outer.pack(fill="both", expand=True, padx=2, pady=2)
    tk.Frame(outer, bg=BORDER_LT, height=2).pack(fill="x")
    tk.Frame(outer, bg=BORDER_LT, width=2).place(x=0, y=0, relheight=1)
    tk.Frame(outer, bg=BORDER_DK, height=2).pack(side="bottom", fill="x")

    title_bar = tk.Frame(outer, bg=TITLE_BG, height=20)
    title_bar.pack(fill="x", padx=2, pady=(2, 0))
    tk.Label(
        title_bar, text="  jouko.exe",
        bg=TITLE_BG, fg=TITLE_FG,
        font=TITLE_FONT, anchor="w"
    ).pack(side="left", fill="both", expand=True)

    content = tk.Frame(outer, bg=WIN_BG)
    content.pack(fill="both", expand=True, padx=4, pady=4)

    if PHOTO:
        lbl = tk.Label(content, image=PHOTO, bg=WIN_BG, bd=0)
        lbl.image = PHOTO   # explicit ref per window biar gak ke-GC
        lbl.pack(pady=(8, 6))
    else:
        tk.Label(content, text="[image missing]", bg=WIN_BG, fg="#000").pack(pady=30)

    ef = tk.Frame(content, bg=INSET_DK)
    ef.pack(padx=20, pady=(0, 6))
    inner = tk.Frame(ef, bg=ENTRY_BG)
    inner.pack(padx=1, pady=1)

    var = tk.StringVar()
    entry = tk.Entry(
        inner, textvariable=var,
        bg=ENTRY_BG, fg=ENTRY_FG,
        insertbackground="#000000",
        relief="flat", bd=4,
        font=ENTRY_FONT,
        justify="center", width=20
    )
    entry.pack()

    def on_enter(e):
        if var.get().strip() == "Jouko":
            close_all_windows()

    entry.bind("<Return>", on_enter)
    win.protocol("WM_DELETE_WINDOW", lambda w=win: on_window_close(w))
    return win

def main():
    global ROOT, PHOTO, TITLE_FONT, ENTRY_FONT, SCR_W, SCR_H

    ROOT = tk.Tk()
    ROOT.withdraw()

    SCR_W = ROOT.winfo_screenwidth()
    SCR_H = ROOT.winfo_screenheight()

    # load gambar pakai NEAREST buat speed — beda tipis visually, jauh lebih cepat
    try:
        img = Image.open(resource_path("chara.png"))
        img = img.resize((200, 200), Image.NEAREST)
        PHOTO = ImageTk.PhotoImage(img)
    except Exception:
        PHOTO = None

    # set window icon
    try:
        ROOT.iconbitmap(resource_path("icon.ico"))
    except Exception:
        pass

    try:
        TITLE_FONT = tkfont.Font(family="MS Sans Serif", size=8, weight="bold")
    except Exception:
        TITLE_FONT = ("Courier", 8, "bold")
    try:
        ENTRY_FONT = tkfont.Font(family="Courier New", size=10)
    except Exception:
        ENTRY_FONT = ("Courier", 10)

    create_window()
    ROOT.mainloop()

if __name__ == "__main__":
    main()
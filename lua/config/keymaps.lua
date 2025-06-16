-- better up/down
vim.keymap.set({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Go to left window", remap = true })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Go to lower window", remap = true })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Go to upper window", remap = true })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Go to right window", remap = true })

-- Remap digraph kyebinding
vim.keymap.set("i", "<C-f>", "<C-k>")

-- Add semicolon eol
-- TODO: figure out why <C-;> doesn't work
vim.keymap.set("n", "<leader>;", "A;<esc>", { silent = true, desc = "Add semicolon at the end of the line" })

-- Move in insert and command mode
vim.keymap.set({ "i", "c" }, "<C-h>", "<Left>", { remap = true })
vim.keymap.set({ "i", "c" }, "<C-j>", "<Down>", { remap = true })
vim.keymap.set({ "i", "c" }, "<C-k>", "<Up>", { remap = true })
vim.keymap.set({ "i", "c" }, "<C-l>", "<Right>", { remap = true })

-- Resize window using <ctrl> arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Move Lines
vim.keymap.set("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move down" })
vim.keymap.set("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move up" })
vim.keymap.set("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
vim.keymap.set("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
vim.keymap.set("v", "<A-j>", ":m '>+1<cr>gv=gv", { desc = "Move down" })
vim.keymap.set("v", "<A-k>", ":m '<-2<cr>gv=gv", { desc = "Move up" })

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "[b", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "]b", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set(
  "n",
  "<leader>bv",
  "<cmd>vsplit %<cr> | <C-w>h | <cmd>bprevious<cr> | <C-w>l",
  { desc = "Open current buffer in vsplit" }
)

-- Keymaps for better default experience
vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })
vim.keymap.set("n", "<leader>h", "<cmd>noh<cr>", { desc = "Turn off current highlighting" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
vim.keymap.set("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- save file
vim.keymap.set({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

-- paste without overwriting register
vim.keymap.set("v", "p", '"_dP"', { desc = "Paste without overwriting the register" })

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- lazy
vim.keymap.set("n", "<leader>l", "<cmd>Lazy<cr>", { desc = "Lazy" })
vim.keymap.set("n", "<leader>m", "<cmd>Mason<cr>", { desc = "Mason" })

-- quickfix
vim.keymap.set("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
vim.keymap.set("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- diagnostic
local diagnostic_goto = function(next, severity)
  local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
  severity = severity and vim.diagnostic.severity[severity] or nil
  return function()
    go({ severity = severity })
  end
end

vim.keymap.set("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
vim.keymap.set("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
vim.keymap.set("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
vim.keymap.set("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
vim.keymap.set("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
vim.keymap.set("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })
vim.keymap.set("n", "<leader>f", vim.diagnostic.open_float, { desc = "Open floating diagnostic message" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

--telescope
vim.keymap.set("n", "<leader>?", require("telescope.builtin").oldfiles, { desc = "Find recently opened files" })
vim.keymap.set("n", "<leader><space>", require("telescope.builtin").buffers, { desc = "Find existing buffers" })
vim.keymap.set("n", "<leader>sb", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end, { desc = "Fuzzy search in current buffer" })

vim.keymap.set("n", "<leader>gf", require("telescope.builtin").git_files, { desc = "Search git files" })
vim.keymap.set("n", "<leader>sf", require("telescope.builtin").find_files, { desc = "Search files" })
vim.keymap.set("n", "<leader>sh", require("telescope.builtin").help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>sw", require("telescope.builtin").grep_string, { desc = "Search current word" })
vim.keymap.set("n", "<leader>sg", require("telescope.builtin").live_grep, { desc = "Search by grep" })
vim.keymap.set("n", "<leader>sd", require("telescope.builtin").diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>sr", require("telescope.builtin").resume, { desc = "Search resume" })
vim.keymap.set("n", "<leader>so", require("telescope.builtin").oldfiles, { desc = "Search recently opened files" })

-- lazygit window
local Terminal = require("toggleterm.terminal").Terminal
local lazygit = Terminal:new({
  cmd = "lazygit",
  direction = "float",
  hidden = true,
  on_open = function(_)
    vim.keymap.del("t", "<C-h>", { buffer = 0 })
    vim.keymap.del("t", "<C-k>", { buffer = 0 })
    vim.keymap.del("t", "<C-l>", { buffer = 0 })
  end,
})

function _Lazygit_toggle()
  lazygit:toggle()
end

vim.api.nvim_set_keymap(
  "n",
  "<leader>gg",
  "<cmd>lua _Lazygit_toggle()<CR>",
  { noremap = true, silent = true, desc = "Open lazygit" }
)

-- Floaterm
function _G.set_terminal_keymaps()
  local opts = { buffer = 0 }
  vim.keymap.set("t", "<C-h>", [[<Cmd>wincmd h<CR>]], opts)
  vim.keymap.set("t", "<C-k>", [[<Cmd>wincmd k<CR>]], opts)
  vim.keymap.set("t", "<C-l>", [[<Cmd>wincmd l<CR>]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
-- vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

vim.api.nvim_create_autocmd({ "TermOpen" }, {
  pattern = "term://*",
  callback = set_terminal_keymaps,
})

local function insert_code_block()
  local in_chunk, _ = require("otter.keeper").get_current_language_context()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes("<esc>", true, false, true), "n", true
  )
  local keys
  if in_chunk then
    keys = "o```<cr><cr>```{python}<esc>o"
  else
    keys = "o```{python}<cr>```<esc>O"
  end
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  vim.api.nvim_feedkeys(keys, 'n', false)
end

-- Quarto/molten
vim.keymap.set("n", "<leader>js", "<cmd>MoltenInit<cr>", { silent = true, noremap = true, desc = "Start kernel" })
vim.keymap.set("n", "<leader>je", ":noautocmd MoltenEnterOutput<CR>", { silent = true, desc = 'Show/enter output' })
vim.keymap.set("n", "<leader>jb", "<cmd>QuartoSendBelow<cr>", { desc = "Run all cell below" })
vim.keymap.set("n", "<leader>jd", "<cmd>QuartoSendAbove<cr>", { desc = "Run all cell above" })
vim.keymap.set("n", "<leader>ja", "<cmd>QuartoSendAll<cr>", { desc = "Run all cell" })
vim.keymap.set("n", "<leader>jc", "<cmd>QuartoSend<cr>", { desc = "Run current cell" })
vim.keymap.set("n", "<leader>jp", insert_code_block, { desc = "Insert Python code chunk" })
vim.keymap.set("n", "<leader>jo", require("otter").activate, { desc = "Activate otter" })

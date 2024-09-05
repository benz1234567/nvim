local obsidian = { }

-- go to linked file under cursor
vim.keymap.set('n', '<leader>o', function() 
  local function get_link_under_cursor()
    local cursor_pos = vim.api.nvim_win_get_cursor(0)
    local line = vim.api.nvim_get_current_line()
    local col = cursor_pos[2] -- 0-based column index

    -- Pattern to match Obsidian links
    local pattern = "%[%[.-%]%]"
    local links = {}

    -- Iterate over all matches
    local start_pos = 1
    while true do
      local start_col, end_col = string.find(line, pattern, start_pos)
      if not start_col then
        break
      end

      -- Adjust start_col and end_col to be 0-based
      table.insert(links, { start_col = start_col - 1, end_col = end_col })
      start_pos = end_col + 1
    end

    -- Find the link closest to the cursor
    local closest_link = nil

    for _, link in ipairs(links) do
      local start_col = link.start_col
      local end_col = link.end_col

      if col >= start_col and col <= end_col then
        closest_link = link
      end
    end

    if closest_link then
      return string.sub(line, closest_link.start_col + 1, closest_link.end_col)
    else
      return nil
    end
  end
  local link = get_link_under_cursor()
  if link then
    -- Call the external script and get the file path
    local handle = io.popen("echo " .. vim.fn.shellescape(link) .. " | filefromlink 2>/dev/null")
    local file_path = handle:read("*a"):gsub("\n$", ""):gsub("^'%s*(.-)%s*'$", "%1")
    handle:close()

    if not file_path or file_path == "" then
      print("No file path returned from script")
      return
    end

    -- Open the file in a new buffer
    print(file_path)
    vim.cmd("edit " .. file_path)
  end
end)

-- Autocomplete for links when starting to type [[

local function is_inside_obsidian_link()
  -- Get the current line and cursor position
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')

  -- Ensure the cursor is within the valid range
  if col <= 2 or col > #line + 1 then
    return false, nil
  end

  -- Extract relevant portion of the line
  local text_before_cursor = line:sub(1, col - 1)

  local idx = 1
  local bracketcount = 0
  local fzf = ""

  for idx = #text_before_cursor, 1, -1 do
    local letter = text_before_cursor:sub(idx, idx)
    print(letter)
    if letter == "[" then
      bracketcount = bracketcount + 1
      print("letter is a bracket")
      if bracketcount < 2 then
        print("bracketcount = " .. bracketcount)
      else
        print("breaking out, 2 brackets found")
        fzf = text_before_cursor:sub(idx, #text_before_cursor)
        print(fzf)
        break
      end
    elseif letter == " " or not letter or letter == "]" then
      print("letter is a space or bracket or doesn't exist, returning false")
      return false, fzf
    end
  end

  if not ( bracketcount >= 2 ) then
    return false, fzf
  end

  local text_after_cursor = line:sub(col, #line)
  for idx = 1, #text_after_cursor do
    local letter = text_after_cursor:sub(idx, idx)
    print(letter)
    if not letter or letter == " " or letter == "[" then
      print("letter doesn't exist, is a space, or an operning bracket, returning true")
      return true, fzf
    elseif letter == "]" then
      print("letter is a closing bracket, returning false")
      return false, fzf
    end
  end

  return true, fzf
end

vim.keymap.set('i', '<C-t>', function()
  local shouldcomplete, fzf = is_inside_obsidian_link()
  print(shouldcomplete, fzf)

  if shouldcomplete then
    local items = { }
    local handle = io.popen('obsidiancmplinks ' .. vim.fn.shellescape(fzf)) -- Replace with the path if needed
    local output = handle:read('*a')
    handle:close()

    -- Split the output into lines and convert to completion items
    for line in output:gmatch("[^\r\n]+") do
      print(line)
      table.insert(items, line)
    end
    vim.fn.complete(vim.fn.col('.') - #fzf, items) 
  end
end)

vim.keymap.set('n', '<C-t>', function()
  print(is_inside_obsidian_link())
end)

-- Crosslink file on save
vim.api.nvim_create_autocmd("BufWritePost", {
  callback = function()
    os.execute("crosslink " .. vim.api.nvim_buf_get_name(0) .. " 2>/dev/null")
  end
})

vim.keymap.set('n', '<leader>r', function()
  local line = vim.fn.getline('.')
  local col = vim.fn.col('.')

  -- Ensure the cursor is within the valid range
  if col <= 2 or col > #line + 1 then
    return false
  end

  -- Extract relevant portion of the line
  local text_before_cursor = line:sub(1, col - 1)

  local idx = 1
  local bracketcount = 0
  local linkstart = 0
  local linkend = 0

  for idx = #text_before_cursor, 1, -1 do
    local letter = text_before_cursor:sub(idx, idx)
    if letter == "[" then
      bracketcount = bracketcount + 1
      if bracketcount < 2 then
      else
        linkstart = idx
        break
      end
    elseif letter == " " or not letter or letter == "]" or bracketcount == 1 then
      return false
    end
  end

  if not ( bracketcount >= 2 ) then
    return false
  end

  bracketcount = 0
  local text_after_cursor = line:sub(col, #line)
  for idx = 1, #text_after_cursor do
    local letter = text_after_cursor:sub(idx, idx)
    if letter == "]" then
      bracketcount = bracketcount + 1
      if bracketcount >= 2 then
        linkend = idx + col
        break
      end
    elseif not letter or letter == " " or letter == "[" or bracketcount == 1 then
      return false
    end
  end
  os.execute("crosslink " .. vim.api.nvim_buf_get_name(0) .. " 2>/dev/null")
  os.execute("notify-send $(echo '" .. line:sub(linkstart, linkend) .. "' | filefromlink)")
end)

return obsidian

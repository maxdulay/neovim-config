require("image").setup({
  backend = "kitty",
  integrations = {
    markdown = {
    resolve_image_path = function(document_path, image_path, fallback)
		image_path = "/home/maxdu/Documents/Obsidian/Notes/" .. image_path

		return fallback(document_path, image_path)
	end,
      enabled = true,
      clear_in_insert_mode = true,
      download_remote_images = true,
      only_render_image_at_cursor = false,
      filetypes = { "markdown" }, -- markdown extensions (ie. quarto) can go here
    },
    html = {
      enabled = false,
    },
    css = {
      enabled = false,
    },
  },
  max_width = nil,
  max_height = nil,
  max_width_window_percentage = nil,
  max_height_window_percentage = 50,
  window_overlap_clear_enabled = false, -- toggles images when windows are overlapped
  window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
  editor_only_render_when_focused = false, -- auto show/hide images when the editor gains/looses focus
  tmux_show_only_in_active_window = false, -- auto show/hide images in the correct Tmux window (needs visual-activity off)
  hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp", "*.avif" }, -- render image files as images when opened
})
require('render-markdown').setup({
    -- Checkboxes are a special instance of a 'list_item' that start with a 'shortcut_link'
    -- There are two special states for unchecked & checked defined in the markdown grammar
	
    bullet = {
        -- Turn on / off list bullet rendering
        enabled = true,
        icons = { '●', '○', '◆', '◇' },
        -- Padding to add to the left of bullet point
        left_pad = 0,
        -- Padding to add to the right of bullet point
        right_pad = 1,
        -- Highlight for the bullet icon
        highlight = 'RenderMarkdownBullet',
    },
    checkbox = {
        -- Turn on / off checkbox state rendering
        enabled = true,
    },
    link = {
		enabled = true,
	},
    maid = {
		enabled = true,
	},

})
require("diagram").setup({
  integrations = {
    require("diagram.integrations.markdown"),
    require("diagram.integrations.neorg"),
  },
  renderer_options = {
    mermaid = {
    },
    plantuml = {
      charset = "utf-8",
    },
    d2 = {
      theme_id = 1,
    },
  },
})

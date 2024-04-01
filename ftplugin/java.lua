bundles = {
	vim.fn.glob('~/Documents/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar'),
}

on_attach = function(client, bufnr) 
	require('jdtls').setup_dap({hotcodereplace = 'auto' })
end
local config = {
    cmd = {vim.fn.expand('~/.local/share/nvim/mason/bin/jdtls')},
    root_dir = vim.fs.dirname(vim.fs.find({'gradlew', '.git', 'mvnw'}, { upward = true })[1]),
	on_attach = on_attach,
	init_options = {
	bundles = bundles
  },
}

config['on_attach'] = function(client, bufnr)
  -- With `hotcodereplace = 'auto' the debug adapter will try to apply code changes
  -- you make during a debug session immediately.
  -- Remove the option if you do not want that.
  require('jdtls').setup_dap({ hotcodereplace = 'auto' })
end
require('jdtls').start_or_attach(config)

require("neotest").setup({
  adapters = {
    require("neotest-java")({
        ignore_wrapper = false, -- whether to ignore maven/gradle wrapper
    })
  }
})


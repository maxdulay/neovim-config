vim.g.firenvim_config = {
    localSettings = {
        ['.txt'] = {
            filename = '/tmp/{hostname}_{pathname%10}.md'
        }
    }
}

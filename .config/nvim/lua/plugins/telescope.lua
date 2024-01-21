return {
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    version = "*",
    build = 'make'
  },
  {
    'nvim-telescope/telescope.nvim',
    version = "*",
    dependencies = {
      'nvim-telescope/telescope-fzf-native.nvim',
      'nvim-lua/plenary.nvim',
    }
  }
}

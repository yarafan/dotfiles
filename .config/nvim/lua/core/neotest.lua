local neotest_golang_opts = {
  runner = "gotestsum",
  gotestsum_args = { "--format=dots" }
}
require("neotest").setup({
  adapters = {
    require("neotest-golang")(neotest_golang_opts),
  },
})

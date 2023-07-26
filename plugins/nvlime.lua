vim.cmd [[
function! NvlimeBuildServerCommandFor_mondo(nvlime_loader, nvlime_eval)
    return ["mondo", "--no-color", "--server", "vlime"]
endfunction
]]

return {
    "monkoose/nvlime",
    dependencies = {
      "monkoose/parsley",
    }
}

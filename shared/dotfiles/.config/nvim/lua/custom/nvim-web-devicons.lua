local nvim_web_devicons_ok, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
if not nvim_web_devicons_ok then
  return
end

nvim_web_devicons.set_icon({
  tf = {
    icon = '',
    color = '#e79aff',
    cterm_color = '98',
    name = 'Terraform'
  }
})

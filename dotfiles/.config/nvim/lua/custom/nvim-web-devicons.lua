local setup, nvim_web_devicons = pcall(require, 'nvim-web-devicons')
if not setup then
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

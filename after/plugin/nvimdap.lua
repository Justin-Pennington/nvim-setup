local dap = require('dap');
local dapui = require('dapui')

vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint)
vim.keymap.set('n', '<leader>gb', dap.run_to_cursor)

vim.keymap.set('n','<leader>dc', dap.continue)
vim.keymap.set('n','<leader>si', dap.step_into)
vim.keymap.set('n','<leader>so', dap.step_over)
vim.keymap.set('n','<leader>dso', dap.step_out)
vim.keymap.set('n','<leader>sb', dap.step_back)
vim.keymap.set('n','<leader>dr', dap.step_back)
vim.keymap.set('n','<leader>cui', function()
  dapui.close()
end
)

--vim.keymap.set('n', '<leader>?', function()
dapui.setup()

vim.keymap.set('n','<leader>?', function()
        dapui.eval(nil, {enter = true})
    end
)

dap.adapters["pwa-node"] = {
    type="server",
    host="127.0.0.1",
    port = 8465,
    cwd = vim.fn.getcwd(),
    executable = {
        command = "js-debug-adapter"
    }
}


for _, language in ipairs { "typescript", "javascript" } do
    dap.configurations[language] = {
        {
            type='pwa-node',
            request = 'launch',
            name = 'launch file',
            program = "${file}",
            runtimeExecutable = 'node',
            cwd = vim.fn.getcwd(),
        },
        {
            type = "pwa-node",
            request = "attach",
            name = "Attach",
            processId = require("dap.utils").pick_process,
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
        },
        {
            type = "pwa-chrome",
            request = "launch",
            name = "Launch & Debug Chrome",
            url = function()
              local co = coroutine.running()
              return coroutine.create(function()
                vim.ui.input({
                  prompt = "Enter URL: ",
                  default = "http://localhost:3000",
                }, function(url)
                  if url == nil or url == "" then
                    return
                  else
                    coroutine.resume(co, url)
                  end
                end)
              end)
            end,
            webRoot = vim.fn.getcwd(),
            protocol = "inspector",
            sourceMaps = true,
            userDataDir = false,
        },
    }
end


dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end
dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

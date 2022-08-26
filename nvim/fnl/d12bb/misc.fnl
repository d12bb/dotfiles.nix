(let [ap (require :nvim-autopairs)]
  (ap.setup {:enable_check_bracket_line false}))

(let [c (require :Comment)]
  (c.setup))

(let [f (require :fidget)]
  (f.setup))

(let [lspsaga (require :lspsaga)]
  (lspsaga.init_lsp_saga {:code_action_lightbulb {:virtual_text true}
                          :symbol_in_winbar {:enable true}}))

(let [ts (require :telescope)]
  (ts.setup {:defaults {:layout_strategy :flex}
             :ensure_installed [:bash
                                :c
                                :comment
                                :css
                                :fennel
                                :fish
                                :gitignore
                                :go
                                :gomod
                                :gowork
                                :help
                                :html
                                :lua
                                :make
                                :markdown
                                :markdown_inline
                                :python
                                :ruby
                                :rust
                                :swift
                                :toml
                                :vim
                                :yaml]
             :extensions {:dash {:dash_app_path :/Applications/Setapp/Dash.app}
                          :fzf {:fuzzy true
                                :override_generic_sorter true
                                :override_file_sorter true
                                :case_mode :smart_case}}})
  (ts.load_extension :fzf))

(let [tsc (require :nvim-treesitter.configs)]
  (tsc.setup {:highlight {:enable true}
              :rainbow {:enable true}
              :textobjects {:select {:enable true
                                     :keymaps {:af "@function.outer"
                                               :if "@function.inner"
                                               :ac "@class.outer"
                                               :ic "@class.inner"}}
                            :move {:enable true
                                   :goto_next_start {"]m" "@function.outer"
                                                     "]]" "@class.outer"}
                                   :goto_next_end {"]M" "@function.outer"
                                                   "][" "@class.outer"}
                                   :goto_previous_start {"[m" "@function.outer"
                                                         "[[" "@class.outer"}
                                   :goto_previous_end {"[M" "@function.outer"
                                                       "[]" "@class.outer"}}}}))

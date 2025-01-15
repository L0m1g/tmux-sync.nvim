#  tmux-sync.nvim

 **Synchronisation automatique des couleurs entre Neovim et Tmux** selon le mode d'édition.

 **Modes pris en charge :**  
-  **Normal** → Couleur synchronisée avec le mode Normal de Neovim.  
-  **Insert** → Couleur synchronisée avec le mode Insert.  
-  **Visual** → Couleur synchronisée avec le mode Visual.  
-  **Command** → Couleur synchronisée avec le mode Command.

---

##  **Fonctionnalités**

- Synchronisation **en temps réel** de la couleur de la **status bar Tmux** avec Neovim.  
- Intégration directe avec **`mini.statusline`**.  
- Ultra léger et sans configuration obligatoire.

---

##  **Installation**

### Avec **Lazy.nvim**

```lua
{
    "L0m1g/tmux-sync.nvim",
    dependencies = {
        "echasnovski/mini.statusline",  --  Nécessaire pour récupérer les couleurs
    },
    config = function()
        require("tmux-sync")
    end,
}
```

### Avec **Packer.nvim**

```lua
use({
    "L0m1g/tmux-sync.nvim",
    requires = { "echasnovski/mini.statusline" },
    config = function()
        require("tmux-sync")
    end,
})
```

## Configuration

Aucune configuration n’est nécessaire, mais tu peux personnaliser les couleurs avec mini.statusline si besoin.

## Fonctionnement 

Le plugin écoute les changements de mode dans Neovim et met à jour la couleur de la status bar de Tmux.

Exemple de synchronisation :
	•	Mode Normal → Orange 
	•	Mode Insert → Vert 
	•	Mode Visual → Rouge 
	•	Mode Command → Bleu

## Licence 

Distribué sous Licence MIT 


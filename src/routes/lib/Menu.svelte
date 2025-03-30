<script lang="ts">
    // Inicio, Lançamentos, Contas, Categorias, Relatórios
    let item = [
        {'label': 'Inicio'},
        {'label': 'Lançamentos'},
        {'label': 'Contas'},
        {'label': 'Categorias'},
        {'label': 'Relatórios'},
    ]
</script>

{#each item as {label}}
<p class="text-gray-800 transition-colors duration-300 transform dark:text-gray-200 mx-1.5 sm:mx-6 cursor-pointer">
    {label}
</p>
{/each}

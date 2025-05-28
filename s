<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sansão Suplementos</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            max-width: 1200px;
            margin: 0 auto;
            padding: 20px;
        }
        .header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 20px;
        }
        .container {
            margin-bottom: 30px;
        }
        .produto {
            border: 1px solid #ccc;
            border-radius: 8px;
            padding: 15px;
            width: 220px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
            transition: transform 0.3s;
        }
        .produto:hover {
            transform: translateY(-5px);
        }
        .produto img {
            width: 100%;
            height: 180px;
            object-fit: cover;
            border-radius: 5px;
        }
        .produto-info h3 {
            margin: 10px 0;
        }
        .categoria-btns {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
        }
        button {
            padding: 8px 15px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        input, select {
            padding: 8px;
            margin: 5px 0;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 100%;
        }
        form {
            display: flex;
            flex-direction: column;
            gap: 10px;
            max-width: 500px;
        }
        .form-actions {
            display: flex;
            gap: 10px;
        }
        #produtosContainer {
            display: flex;
            flex-wrap: wrap;
            gap: 20px;
        }
        .section-title {
            border-bottom: 2px solid #4CAF50;
            padding-bottom: 5px;
            margin-top: 30px;
        }
        .entrega-section {
            background-color: #f9f9f9;
            padding: 15px;
            border-radius: 8px;
            margin-top: 20px;
        }
        #listaPedidos {
            list-style-type: none;
            padding: 0;
        }
        #listaPedidos li {
            padding: 10px;
            border-bottom: 1px solid #eee;
        }
        /* Modal de entrega */
        .modal {
            display: none;
            position: fixed;
            z-index: 1000;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            background-color: rgba(0,0,0,0.5);
        }
        .modal-content {
            background-color: white;
            margin: 10% auto;
            padding: 20px;
            border-radius: 8px;
            max-width: 500px;
            box-shadow: 0 4px 8px rgba(0,0,0,0.2);
        }
        .close-btn {
            float: right;
            font-size: 24px;
            font-weight: bold;
            cursor: pointer;
        }
        .close-btn:hover {
            color: #777;
        }
        .etapas-pedido {
            display: flex;
            justify-content: space-between;
            margin-bottom: 20px;
        }
        .etapa {
            text-align: center;
            flex: 1;
            position: relative;
        }
        .etapa:not(:last-child):after {
            content: "";
            position: absolute;
            top: 15px;
            right: -50%;
            width: 100%;
            height: 2px;
            background-color: #ddd;
            z-index: -1;
        }
        .etapa-numero {
            display: inline-block;
            width: 30px;
            height: 30px;
            line-height: 30px;
            border-radius: 50%;
            background-color: #4CAF50;
            color: white;
            margin-bottom: 5px;
        }
        .etapa-atual .etapa-numero {
            background-color: #2196F3;
        }
        .cupom-section {
            margin-top: 20px;
            padding: 15px;
            border: 1px dashed #4CAF50;
            border-radius: 8px;
            background-color: #f0f8f0;
        }
        .cupom-aplicado {
            color: #4CAF50;
            font-weight: bold;
        }
        .preco-riscado {
            text-decoration: line-through;
            color: #777;
            margin-right: 10px;
        }
    </style>
</head>
<body>
    <div class="header">
        <h1>Sansão Suplementos</h1>
        <button id="loginToggleBtn">Login Admin</button>
    </div>

    <div id="adminSection" style="display:none; margin-top:20px;" class="container">
        <h2 class="section-title">Administração de Produtos</h2>
        <form id="produtoForm">
            <input type="hidden" id="produtoIndex" />
            <input type="text" id="produtoNome" placeholder="Nome do produto" required />
            <select id="produtoCategoria" required>
                <option value="">Selecione a categoria</option>
                <option value="pre-treino">Pré-treino</option>
                <option value="creatina">Creatina</option>
            </select>
            <input type="number" step="0.01" id="produtoPreco" placeholder="Preço" required />
            <input type="url" id="produtoImagem" placeholder="URL da imagem" required />
            <div class="form-actions">
                <button type="submit">Salvar Produto</button>
                <button type="button" onclick="cancelarEdicao()">Cancelar</button>
            </div>
        </form>
    </div>

    <div class="container">
        <h2 class="section-title">Produtos</h2>
        <div class="categoria-btns">
            <button onclick="filtrarCategoria('todos')">Todos</button>
            <button onclick="filtrarCategoria('pre-treino')">Pré-treino</button>
            <button onclick="filtrarCategoria('creatina')">Creatina</button>
        </div>
        <div id="produtosContainer"></div>
    </div>

    <div class="container">
        <p id="totalProdutos">Total de produtos: R$ 0.00</p>
        <button onclick="iniciarFinalizacao()">Finalizar Pedido</button>
    </div>

    <!-- Modal de Entrega -->
    <div id="entregaModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="fecharModalEntrega()">&times;</span>
            
            <div class="etapas-pedido">
                <div class="etapa etapa-atual">
                    <div class="etapa-numero">1</div>
                    <div>Entrega</div>
                </div>
                <div class="etapa">
                    <div class="etapa-numero">2</div>
                    <div>Confirmação</div>
                </div>
            </div>
            
            <h2 class="section-title">Calcular Entrega</h2>
            <p>Informe seu bairro ou cidade para calcularmos o frete:</p>
            <select id="bairroSelect">
                <option value="">Selecione seu bairro ou cidade</option>
                <!-- Bairros serão adicionados via JavaScript -->
            </select>
            <p id="resultadoEntregaModal"></p>
            <p id="totalPedidoModal">Total com entrega: R$ 0.00</p>
            <button onclick="confirmarEntrega()">Continuar</button>
        </div>
    </div>

    <!-- Modal de Confirmação -->
    <div id="confirmacaoModal" class="modal">
        <div class="modal-content">
            <span class="close-btn" onclick="fecharModalConfirmacao()">&times;</span>
            
            <div class="etapas-pedido">
                <div class="etapa">
                    <div class="etapa-numero">1</div>
                    <div>Entrega</div>
                </div>
                <div class="etapa etapa-atual">
                    <div class="etapa-numero">2</div>
                    <div>Confirmação</div>
                </div>
            </div>
            
            <h2 class="section-title">Confirmar Pedido</h2>
            <div id="resumoPedido"></div>
            
            <!-- Seção de Cupom de Desconto -->
            <div class="cupom-section">
                <h3>Cupom de Desconto</h3>
                <p>Possui um cupom? Digite abaixo para obter 5% de desconto:</p>
                <div style="display: flex; gap: 10px;">
                    <input id="cupomInput" placeholder="Digite seu cupom" style="flex: 1;" />
                    <button onclick="aplicarCupom()" style="flex-shrink: 0;">Aplicar</button>
                </div>
                <p id="cupomMensagem"></p>
            </div>
            
            <div style="margin-top: 20px;">
                <button onclick="finalizarPedido()">Finalizar Pedido</button>
                <button onclick="voltarParaEntrega()" style="background-color: #777;">Voltar</button>
            </div>
        </div>
    </div>

    <div id="meusPedidosSection" style="display:none; margin-top:20px;" class="container">
        <h2 class="section-title">Meus Pedidos</h2>
        <ul id="listaPedidos"></ul>
    </div>

    <script>
        const ADMIN_EMAIL = "orsinigabriel7@gmail.com";
        const ADMIN_PASSWORD = "Bolsonaro22@";
        const CUPOM_VALIDO = "psychotic";
        const DESCONTO_PORCENTAGEM = 5;
        const TAXA_POR_KM = 2.00; // Taxa de R$ 2,00 por quilômetro para bairros com cálculo por km

        const loginToggleBtn = document.getElementById("loginToggleBtn");
        const adminSection = document.getElementById("adminSection");
        const meusPedidosSection = document.getElementById("meusPedidosSection");
        const listaPedidos = document.getElementById("listaPedidos");
        const entregaModal = document.getElementById("entregaModal");
        const confirmacaoModal = document.getElementById("confirmacaoModal");
        const bairroSelect = document.getElementById("bairroSelect");

        let isAdminLoggedIn = false;
        let produtos = [];
        let valorEntrega = 0;
        let distanciaEntrega = 0;
        let bairroSelecionado = "";
        let cupomAplicado = false;
        let valorDesconto = 0;
        let historicoPedidos = JSON.parse(localStorage.getItem("historicoPedidos")) || [];

        // Tabela de bairros com valores fixos específicos
        const bairrosValoresFixos = {
            // Bairros com valores específicos
            "Ceu Azul": 1.40,
            "Lagoa": 1.40,
            "Trevo": 1.40,
            "Santa Amelia": 1.70,
            "Santa Monica": 1.70,
            "Santa Branca": 1.70,
            "Justinopolis": 1.70,
            "Planalto": 2.00,
            "Itapua": 2.00,
            "Bandeirantes": 2.00,
            
            // Novas cidades adicionadas com valor fixo de R$ 2,00
            "Santa Luzia": 2.00,
            "Sabará": 2.00,
            "Nova Lima": 2.00,
            "Ibirité": 2.00,
            "Contagem": 2.00,
            "Vespasiano": 2.00,
            "Ribeirão das Neves": 2.00 // Ribeirão das Neves com valor padrão (exceto Justinópolis que já está definido acima)
        };

        // Tabela de bairros com distâncias para cálculo por km
        const bairrosDistancias = {
            "Savassi": 4.5,
            "Lourdes": 5.0,
            "Funcionários": 5.2,
            "Serra": 5.5,
            "Sion": 6.0,
            "Anchieta": 6.2,
            "Santo Antônio": 6.5,
            "Cruzeiro": 7.0,
            "Cidade Jardim": 7.2,
            "Mangabeiras": 7.5,
            "Floresta": 8.0,
            "Horto": 8.2,
            "Sagrada Família": 8.5,
            "Santa Tereza": 9.0,
            "Esplanada": 9.2,
            "Vera Cruz": 9.5,
            "União": 10.0,
            "Ipiranga": 10.5,
            "Palmares": 11.0,
            "São Gabriel": 11.5,
            "Renascença": 12.0,
            "Guarani": 12.5,
            "Padre Eustáquio": 13.0,
            "São Cristóvão": 13.5,
            "Caiçara": 14.0,
            "Alípio de Melo": 14.5,
            "Dom Cabral": 15.0,
            "Letícia": 15.5,
            "Mantiqueira": 16.0,
            "Piratininga": 16.5,
            "Nova Suíça": 17.0,
            "Estoril": 17.5,
            "Buritis": 18.0,
            "Grajaú": 18.5,
            "Gutierrez": 19.0,
            "São Luiz": 19.5,
            "Ouro Preto": 20.0,
            "Barreiro de Baixo": 20.5,
            "Milionários": 21.0,
            "Diamante": 21.5,
            "Tirol": 22.0,
            "Independência": 22.5,
            "Jardim dos Comerciários": 23.0,
            "Rio Branco": 23.5,
            "Serra Verde": 24.0
        };

        // Função para verificar parâmetros na URL
        function getParametroURL(nome) {
            const urlParams = new URLSearchParams(window.location.search);
            return urlParams.get(nome);
        }

        // Verificar se há cupom na URL ao carregar a página
        function verificarCupomURL() {
            const cupomURL = getParametroURL('cupom');
            if (cupomURL && cupomURL.toLowerCase() === CUPOM_VALIDO) {
                // Armazenar o cupom para aplicação automática quando o modal de confirmação for aberto
                sessionStorage.setItem('cupomAutomatico', cupomURL);
            }
        }

        // Preencher o select de bairros
        function preencherBairros() {
            bairroSelect.innerHTML = '<option value="">Selecione seu bairro ou cidade</option>';
            
            // Combinar todos os bairros
            const todosBairros = [...Object.keys(bairrosValoresFixos), ...Object.keys(bairrosDistancias)];
            
            // Ordenar bairros alfabeticamente
            const bairrosOrdenados = todosBairros.sort();
            
            bairrosOrdenados.forEach(bairro => {
                const option = document.createElement('option');
                option.value = bairro;
                option.textContent = bairro;
                bairroSelect.appendChild(option);
            });
        }

        function carregarProdutos() {
            const prods = localStorage.getItem("produtosSansao");
            if (prods) {
                produtos = JSON.parse(prods);
            } else {
                produtos = [
                    { nome: "Demons Lab Pré-Treino X", categoria: "pre-treino", preco: 129.90, imagem: "https://m.media-amazon.com/images/I/61Dg8FxN6uL.AC_SX679.jpg" },
                    { nome: "Demons Lab Pré-Treino Y", categoria: "pre-treino", preco: 139.90, imagem: "https://m.media-amazon.com/images/I/71JqoIKJpZL.AC_SX679.jpg" },
                    { nome: "Creatina Sansão", categoria: "creatina", preco: 89.90, imagem: "https://m.media-amazon.com/images/I/61aat0fOMlL.AC_SX679.jpg" }
                ];
                salvarProdutos();
            }
        }

        function salvarProdutos() {
            localStorage.setItem("produtosSansao", JSON.stringify(produtos));
        }

        function renderizarProdutos(categoria = "todos") {
            const container = document.getElementById("produtosContainer");
            container.innerHTML = "";

            const filtrados = categoria === "todos" ? produtos : produtos.filter(p => p.categoria === categoria);

            if (filtrados.length === 0) {
                container.innerHTML = "<p>Nenhum produto encontrado.</p>";
                return;
            }

            filtrados.forEach((produto, index) => {
                const div = document.createElement("div");
                div.className = "produto";
                div.innerHTML = `
                    <img src="${produto.imagem}" alt="${produto.nome}" />
                    <div class="produto-info">
                        <h3>${produto.nome}</h3>
                        <p>Categoria: ${produto.categoria}</p>
                        <p>Preço: R$ ${produto.preco.toFixed(2)}</p>
                    </div>
                    ${isAdminLoggedIn ? `
                        <div class="produto-actions" style="margin-top:10px;">
                            <button onclick="editarProduto(${index})">Editar</button>
                            <button onclick="removerProduto(${index})">Remover</button>
                        </div>` : ""}
                `;
                container.appendChild(div);
            });
            
            atualizarTotalProdutos();
        }

        function filtrarCategoria(cat) {
            renderizarProdutos(cat);
        }

        function calcularEntregaPorBairro(bairro) {
            const resultado = document.getElementById("resultadoEntregaModal");
            
            if (!bairro) {
                valorEntrega = -1;
                distanciaEntrega = 0;
                bairroSelecionado = "";
                resultado.innerText = "Por favor, selecione um bairro ou cidade válido.";
                return false;
            }
            
            // Verificar se o bairro tem valor fixo específico
            if (bairrosValoresFixos.hasOwnProperty(bairro)) {
                valorEntrega = bairrosValoresFixos[bairro];
                bairroSelecionado = bairro;
                
                // Para bairros com valor fixo, não mostramos a distância
                resultado.innerText = Entrega para ${bairro}: R$ ${valorEntrega.toFixed(2)};
                return true;
            }
            
            // Verificar se o bairro tem cálculo por km
            if (bairrosDistancias.hasOwnProperty(bairro)) {
                // Obter a distância do bairro selecionado
                distanciaEntrega = bairrosDistancias[bairro];
                
                // Calcular o valor da entrega com base na distância
                valorEntrega = distanciaEntrega * TAXA_POR_KM;
                bairroSelecionado = bairro;
                
                resultado.innerText = Entrega para ${bairro} (${distanciaEntrega.toFixed(1)} km): R$ ${valorEntrega.toFixed(2)};
                return true;
            }
            
            // Se chegou aqui, o bairro não está em nenhuma das listas
            valorEntrega = -1;
            distanciaEntrega = 0;
            bairroSelecionado = "";
            resultado.innerText = "Bairro ou cidade não encontrado em nossa área de entrega.";
            return false;
        }

        function calcularTotalCarrinho() {
            return produtos.reduce((total, prod) => total + prod.preco, 0);
        }

        function atualizarTotalProdutos() {
            const totalCarrinho = calcularTotalCarrinho();
            document.getElementById("totalProdutos").innerText = Total de produtos: R$ ${totalCarrinho.toFixed(2)};
        }

        function atualizarTotalPedidoModal() {
            const totalCarrinho = calcularTotalCarrinho();
            let total = 0;

            if (valorEntrega >= 0) {
                total = totalCarrinho + valorEntrega;
                document.getElementById("totalPedidoModal").innerText = Total com entrega: R$ ${total.toFixed(2)};
            } else {
                document.getElementById("totalPedidoModal").innerText = Total de produtos: R$ ${totalCarrinho.toFixed(2)} (selecione o bairro para calcular a entrega);
            }
        }

        function exibirPedidos() {
            if (historicoPedidos.length === 0) {
                meusPedidosSection.style.display = "none";
                return;
            }
            meusPedidosSection.style.display = "block";
            listaPedidos.innerHTML = "";
            historicoPedidos.forEach((pedido, i) => {
                const li = document.createElement("li");
                li.innerText = Pedido ${i + 1}: ${pedido};
                listaPedidos.appendChild(li);
            });
        }

        function iniciarFinalizacao() {
            const totalCarrinho = calcularTotalCarrinho();
            if (totalCarrinho === 0) {
                alert("Seu carrinho está vazio.");
                return;
            }

            // Limpar campos do modal
            bairroSelect.value = "";
            document.getElementById("resultadoEntregaModal").innerText = "";
            valorEntrega = 0;
            distanciaEntrega = 0;
            bairroSelecionado = "";
            
            // Resetar cupom
            cupomAplicado = false;
            valorDesconto = 0;
            document.getElementById("cupomInput").value = "";
            document.getElementById("cupomMensagem").innerText = "";
            
            // Atualizar total no modal
            atualizarTotalPedidoModal();
            
            // Exibir modal de entrega
            entregaModal.style.display = "block";
        }

        function fecharModalEntrega() {
            entregaModal.style.display = "none";
        }

        function fecharModalConfirmacao() {
            confirmacaoModal.style.display = "none";
        }

        function confirmarEntrega() {
            const bairro = bairroSelect.value;
            if (!bairro) {
                alert("Por favor, selecione um bairro ou cidade para entrega.");
                bairroSelect.focus();
                return;
            }

            // Calcula o frete
            const entregaDisponivel = calcularEntregaPorBairro(bairro);
            if (!entregaDisponivel) {
                alert("Não foi possível calcular o frete. Por favor, selecione um bairro ou cidade válido.");
                bairroSelect.focus();
                return;
            }

            // Atualiza o total com a entrega
            atualizarTotalPedidoModal();
            
            // Preparar resumo do pedido
            atualizarResumoPedido();
            
            // Fechar modal de entrega e abrir modal de confirmação
            entregaModal.style.display = "none";
            confirmacaoModal.style.display = "block";
            
            // Verificar se há cupom automático para aplicar
            const cupomAutomatico = sessionStorage.getItem('cupomAutomatico');
            if (cupomAutomatico) {
                document.getElementById("cupomInput").value = cupomAutomatico;
                aplicarCupom();
                // Limpar o cupom automático após aplicá-lo
                sessionStorage.removeItem('cupomAutomatico');
            }
        }

        function atualizarResumoPedido() {
            const totalCarrinho = calcularTotalCarrinho();
            const totalComFrete = totalCarrinho + valorEntrega;
            let totalFinal = totalComFrete;
            
            // Aplicar desconto se houver cupom
            if (cupomAplicado) {
                valorDesconto = (totalComFrete * DESCONTO_PORCENTAGEM / 100);
                totalFinal = totalComFrete - valorDesconto;
            }
            
            const resumo = document.getElementById("resumoPedido");
            
            // Verificar se é um bairro com valor fixo ou com cálculo por km
            let infoEntrega = '';
            if (bairrosValoresFixos.hasOwnProperty(bairroSelecionado)) {
                infoEntrega = <p><strong>Entrega para ${bairroSelecionado}:</strong> R$ ${valorEntrega.toFixed(2)}</p>;
            } else {
                infoEntrega = <p><strong>Entrega para ${bairroSelecionado} (${distanciaEntrega.toFixed(1)} km):</strong> R$ ${valorEntrega.toFixed(2)}</p>;
            }
            
            resumo.innerHTML = `
                <div style="margin: 20px 0;">
                    <p><strong>Produtos:</strong></p>
                    <ul style="list-style-type: none; padding-left: 10px;">
                        ${produtos.map(p => <li>${p.nome} - R$ ${p.preco.toFixed(2)}</li>).join('')}
                    </ul>
                    <p><strong>Total dos produtos:</strong> R$ ${totalCarrinho.toFixed(2)}</p>
                    ${infoEntrega}
                    ${cupomAplicado ? 
                        `<p><strong>Subtotal:</strong> <span class="preco-riscado">R$ ${totalComFrete.toFixed(2)}</span></p>
                         <p><strong>Desconto (${DESCONTO_PORCENTAGEM}%):</strong> <span class="cupom-aplicado">- R$ ${valorDesconto.toFixed(2)}</span></p>` 
                        : ''}
                    <p style="font-size: 18px; margin-top: 15px;"><strong>Total Final:</strong> R$ ${totalFinal.toFixed(2)}</p>
                </div>
            `;
        }

        function aplicarCupom() {
            const cupomDigitado = document.getElementById("cupomInput").value.trim().toLowerCase();
            const mensagemCupom = document.getElementById("cupomMensagem");
            
            if (!cupomDigitado) {
                mensagemCupom.innerText = "Por favor, digite um cupom.";
                mensagemCupom.style.color = "#f44336";
                return;
            }
            
            if (cupomDigitado === CUPOM_VALIDO) {
                cupomAplicado = true;
                mensagemCupom.innerText = Cupom "${cupomDigitado}" aplicado com sucesso! Desconto de ${DESCONTO_PORCENTAGEM}% no total.;
                mensagemCupom.style.color = "#4CAF50";
                
                // Atualizar resumo do pedido com o desconto
                atualizarResumoPedido();
            } else {
                cupomAplicado = false;
                mensagemCupom.innerText = "Cupom inválido. Tente novamente.";
                mensagemCupom.style.color = "#f44336";
            }
        }

        function voltarParaEntrega() {
            confirmacaoModal.style.display = "none";
            entregaModal.style.display = "block";
        }

        function finalizarPedido() {
            const totalCarrinho = calcularTotalCarrinho();
            const totalComFrete = totalCarrinho + valorEntrega;
            let totalFinal = totalComFrete;
            
            // Aplicar desconto se houver cupom
            if (cupomAplicado) {
                valorDesconto = (totalComFrete * DESCONTO_PORCENTAGEM / 100);
                totalFinal = totalComFrete - valorDesconto;
            }
            
            alert("Pedido finalizado com sucesso!");
            
            // Informações adicionais para o histórico
            let infoPedido = R$ ${totalFinal.toFixed(2)} - ${new Date().toLocaleString()} - Entrega: ${bairroSelecionado};
            
            // Adicionar informação de distância apenas para bairros com cálculo por km
            if (bairrosDistancias.hasOwnProperty(bairroSelecionado)) {
                infoPedido += ` (${distanciaEntrega.toFixed(1)} km)`;
            }
            
            if (cupomAplicado) {
                infoPedido += ` - Cupom: ${CUPOM_VALIDO} (${DESCONTO_PORCENTAGEM}% de desconto)`;
            }
            
            historicoPedidos.push(infoPedido);
            localStorage.setItem("historicoPedidos", JSON.stringify(historicoPedidos));
            
            // Limpar carrinho
            produtos = [];
            salvarProdutos();
            renderizarProdutos();
            
            // Fechar modal
            confirmacaoModal.style.display = "none";
            
            // Exibir histórico de pedidos
            exibirPedidos();
        }

        // Atualizar o total quando o usuário selecionar um bairro
        bairroSelect.addEventListener("change", function() {
            const bairro = this.value;
            if (bairro) {
                calcularEntregaPorBairro(bairro);
                atualizarTotalPedidoModal();
            }
        });

        function loginAdmin() {
            if (isAdminLoggedIn) {
                isAdminLoggedIn = false;
                adminSection.style.display = "none";
                alert("Logout realizado.");
                renderizarProdutos();
                return;
            }

            const email = prompt("Digite o email do administrador:");
            const senha = prompt("Digite a senha do administrador:");

            if (email === ADMIN_EMAIL && senha === ADMIN_PASSWORD) {
                isAdminLoggedIn = true;
                adminSection.style.display = "block";
                alert("Login bem-sucedido como administrador.");
                renderizarProdutos();
            } else {
                alert("Credenciais inválidas.");
            }
        }

        document.getElementById("produtoForm").addEventListener("submit", function (e) {
            e.preventDefault();
            const nome = document.getElementById("produtoNome").value.trim();
            const categoria = document.getElementById("produtoCategoria").value;
            const preco = parseFloat(document.getElementById("produtoPreco").value);
            const imagem = document.getElementById("produtoImagem").value.trim();
            const index = document.getElementById("produtoIndex").value;

            if (!nome || !categoria || isNaN(preco) || !imagem) {
                alert("Preencha todos os campos corretamente.");
                return;
            }

            const novoProduto = { nome, categoria, preco, imagem };

            if (index) {
                produtos[parseInt(index)] = novoProduto;
            } else {
                produtos.push(novoProduto);
            }

            salvarProdutos();
            cancelarEdicao();
            renderizarProdutos();
        });

        function editarProduto(index) {
            const prod = produtos[index];
            document.getElementById("produtoIndex").value = index;
            document.getElementById("produtoNome").value = prod.nome;
            document.getElementById("produtoCategoria").value = prod.categoria;
            document.getElementById("produtoPreco").value = prod.preco;
            document.getElementById("produtoImagem").value = prod.imagem;
            adminSection.scrollIntoView({ behavior: 'smooth' });
        }

        function removerProduto(index) {
            if (confirm("Deseja realmente remover este produto?")) {
                produtos.splice(index, 1);
                salvarProdutos();
                renderizarProdutos();
            }
        }

        function cancelarEdicao() {
            document.getElementById("produtoForm").reset();
            document.getElementById("produtoIndex").value = "";
        }

        // Fechar modais quando clicar fora deles
        window.onclick = function(event) {
            if (event.target == entregaModal) {
                entregaModal.style.display = "none";
            }
            if (event.target == confirmacaoModal) {
                confirmacaoModal.style.display = "none";
            }
        }

        loginToggleBtn.addEventListener("click", loginAdmin);

        // Inicializações
        document.addEventListener('DOMContentLoaded', function() {
            verificarCupomURL();
            preencherBairros();
            carregarProdutos();
            renderizarProdutos();
            exibirPedidos();
        });
    </script>
</body>
</html>

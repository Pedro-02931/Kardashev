# Capítulo 1: Fundação da Fortaleza Digital – Hardening e Otimização de Base no Debian

Antes da neurocirurgia, preparamos o corpo do paciente. Deixar o Debian básico seguro e minimamente otimizado pra aguentar a porrada que vem depois.

**1.1 Setup Inicial e Segurança Básica (O Esqueleto)**

* **Ação:** Atualizar tudo, instalar básicos de segurança (`sudo`, `ufw`, `fail2ban`, `git`), dar poder ao seu usuário.

{% code overflow="wrap" %}
```bash
sudo apt update && sudo apt full-upgrade -y
sudo apt install -y git ufw fail2ban firmware-misc-nonfree intel-microcode firmware-realtek firmware-iwlwifi firmware-linux 
# sudo modprobe iwlwifi
sudo usermod -aG sudo seu_usuario_aqui
```
{% endcode %}

> #### **curl (Client URL) é uma f**erramenta para transferir dados de ou para um servidor usando protocolos como HTTP, FTP, e outros e é amplamente usada para automação de downloads e interações com APIs. Ela envia solicitações de rede através da interface de rede do sistema, utilizando pacotes de dados estruturados conforme o protocolo especificado.
>
> #### **git (Global Information Tracker) é um s**istema de controle de versão distribuído que permite rastrear alterações em arquivos e colaborar em projetos de software. Ele armazena metadados e versões de arquivos no disco, utilizando algoritmos para compressão e diferenciação de dados.
>
> #### **wget (Web Get) é uma f**erramenta para baixar arquivos da web diretamente via linha de comando suportando downloads recursivos e podendo lidar com interrupções. Seu funcionamento é estabelecido conexões com servidores web, solicitando arquivos e os gravando no armazenamento local, utilizando protocolos como HTTP e FTP.
>
> #### **ufw (Uncomplicated Firewall) é uma i**nterface simplificada para gerenciar regras de firewall no Linux. Configura tabelas de filtragem de pacotes no kernel, controlando quais pacotes podem entrar ou sair pela interface de rede.
>
> #### **fail2ban f**erramenta de segurança que monitora logs do sistema para detectar tentativas de acesso malicioso e bloqueia IPs suspeitos. Ele analisa arquivos de log armazenados no disco e interage com o firewall (como ufw) para adicionar regras de bloqueio de IPs.
>
> #### **usermod -aG é o** comando usado para adicionar um usuário a um grupo específico no sistema. O parâmetro `-aG` significa "append to group" (adicionar ao grupo). Modifica os arquivos de configuração de usuários no sistema, atualizando permissões e associações de grupos no disco.
>
> **firmware-misc-nonfree c**ontém firmwares proprietários para dispositivos diversos.
>
> **intel-microcode a**tualiza o microcódigo do processador Intel, corrigindo bugs e melhorando segurança e desempenho.
>
> **firmware-realtek d**rivers de dispositivos Realtek, como placas de rede e áudio.
>
> **firmware-iwlwifi f**irmwares para dispositivos Wi-Fi Intel.
>
> **firmware-linux c**oleção de firmwares para diversos dispositivos suportados pelo kernel Linux.

**1.2 Abrindo as Veias para Sangue Novo (Habilitando Backports)**

* **Ação:** Permitir acesso a pacotes mais recentes (kernel, drivers) sem quebrar a estabilidade do Debian Stable.

{% code overflow="wrap" %}
```bash
deb http://deb.debian.org/debian bookworm-backports main contrib non-free non-free-firmware # Adicionado non-free-firmware
```
{% endcode %}

>
>
> * `deb` indica que esta é uma fonte de pacotes binários (já compilados e prontos para instalação).
> * `bookworm-backports` refere-se ao repositório de **backports** da versão "Bookworm" do Debian.
>   * **Backports** são pacotes mais recentes (de versões de teste ou instáveis) recompilados para funcionar na versão estável do Debian.
> * `main` contém pacotes de software livre que seguem as diretrizes do Debian (DFSG - Debian Free Software Guidelines).
> * `contrib` inclui pacotes de software livre que dependem de componentes não-livres para funcionar (por exemplo, drivers proprietários).
> * `non-free` contém pacotes que não são totalmente livres, como softwares com licenças restritivas.
> * `non-free-firmware` Repositório separado para firmwares proprietários necessários para hardware específico (como placas Wi-Fi ou GPUs).
>   * A partir do Debian 12, firmwares não-livres foram movidos para este repositório dedicado.

**1.3 Kernel Pré-Tunado (O Coração de Atleta - Liquorix)**

* **Ação:** Instalar um kernel (Liquorix) já otimizado pra desktop/jogos, com melhor responsividade que o padrão. Um bom ponto de partida antes da compilação customizada.

{% code overflow="wrap" %}
```bash
# Adicionar repo e chave do Liquorix
curl -s 'https://liquorix.net/add-liquorix-repo.sh' | sudo bash
```
{% endcode %}

> Executa um script que configura o sistema para baixar, instalar e usar o kernel Liquorix no Debian ou Ubuntu seguindo os procedimentos:
>
> 1. **Preparação do Ambiente**:
>    * Verifica se o script está sendo executado como `root` (necessário para modificar o sistema).
>    * Valida a arquitetura do sistema (apenas `x86_64` é suportada).
> 2. **Configuração do Repositório**:
>    * Adiciona o keyring (chave de assinatura digital) do Liquorix para garantir a autenticidade dos pacotes.
>    * Configura o repositório no arquivo `/etc/apt/sources.list.d/liquorix.list` para acesso aos pacotes binários e de código-fonte.
> 3. **Atualização e Instalação**:
>    * Atualiza a lista de pacotes disponíveis com `apt-get update`.
>    * Instala a imagem do kernel Liquorix (`linux-image-liquorix-amd64`) e seus headers (`linux-headers-liquorix-amd64`) necessários para compilar módulos adicionais.
> 4. **Compatibilidade com Distribuições**:
>    * Para Debian: Configura o repositório oficial do Liquorix.
>    * Para Ubuntu: Usa o PPA (Personal Package Archive) específico.
> 5. **Mecanismo de Logs**:
>    * O script fornece feedback detalhado durante o processo através de mensagens de log diferenciadas (INFO e ERROR).
>
> ***
>
>
>
> No nível eletrônico, a instalação do kernel Liquorix altera como o hardware interage com o sistema operacional:
>
> 1. **Keyring**:
>    * O keyring é um arquivo criptográfico armazenado no diretório `/etc/apt/trusted.gpg.d`. Ele garante que os pacotes instalados do repositório Liquorix sejam assinados e legítimos.
> 2. **Repositório**:
>    * O repositório Liquorix hospeda pacotes pré-compilados do kernel otimizados para baixa latência e alta responsividade, ajustando os drivers, a pilha de I/O e os mecanismos de agendamento.
> 3. **Instalação do Kernel**:
>    * `linux-image-liquorix-amd64`: Substitui o kernel padrão pelo Liquorix, ajustando parâmetros de operação para melhorar a performance de desktops e sistemas interativos.
>    * `linux-headers-liquorix-amd64`: Instala arquivos de cabeçalho do kernel, necessários para compilar módulos personalizados (como drivers).
> 4. **Interface com o Hardware**:
>    * O kernel Liquorix utiliza agendadores e configurações ajustadas para maximizar o desempenho de hardware em sistemas com múltiplos núcleos e alto I/O. Isso inclui, por exemplo:
>      * **Otimizações TCP (BBR)** para melhorar performance de rede.
>      * **Ajuste de agendadores de I/O** como `mq-deadline`, priorizando baixa latência em SSDs.
> 5. **Comandos e Configuração**:
>    * Cada comando no script (como `apt-get install`, `curl`, `mkdir`) manipula arquivos no disco, interagindo diretamente com os registros de configuração do sistema.

**1.4 Nootrópico de RAM (Otimização de Swap com ZRAM)**

* **Ação:** Usar RAM comprimida como swap em vez do disco lento do caralho.

{% code overflow="wrap" %}
```sh
sudo apt install -y zram-tools
echo 'PERCENT=75' | sudo tee /etc/default/zramswap
sudo systemctl restart zramswap.service 
```
{% endcode %}

> #### **Por que 50% a 75% da RAM?**
>
> 1. **Características do i3-8130U:**
>    * Apesar desse aquecedor ser meio mediocre, ele é um processador eficiente em consumo energético, mas possui apenas 2 núcleos físicos (4 threads), o que limita sua capacidade de compressão.
> 2. **Benefícios do ZRAM:**
>    * Como ZRAM é um swap baseado em memória comprimida, ele é mais rápido que o swap em disco, mesmo em SSDs.
>    * Com 50% da RAM no cenário mais cu fechado, você cria uma área de swap de 6 GB comprimida, que pode acomodar até 12 GB de dados dependendo da compressão.

**1.5 Afinando a Interface (KDE Plasma - Redução de Latência)**

* **Ação:** Fiz umas otimizações agressivas, segue o script e o raw abaixo:

{% code overflow="wrap" %}
```bash
curl -sSL https://raw.githubusercontent.com/Pedro-02931/Kardashev/refs/heads/scripts/neuro-ergo/neuro_kde_config.sh | bash
```
{% endcode %}

> Este script configura uma interface KDE Plasma altamente otimizada para **latência reduzida e eficiência visual**, com um design alinhado a princípios neurovisuais e minimalistas.
>
> 1. **Configurações de Animação e Efeitos Visuais (**`~/.config/kwinrc`**):**
>    * Desativa efeitos supérfluos, priorizando desempenho.
>    * Reduz a duração das animações e configura o modo de renderização para otimização.
> 2. **Atalhos de Teclado Personalizados (**`~/.config/kglobalshortcutsrc`**):**
>    * Configura atalhos ergonômicos para ações como alternar janelas e organizar áreas de trabalho.
> 3. **Estilo Visual (**`~/.config/plasmarc`**):**
>    * Define um tema minimalista e prático, com a paleta de cores "NeuroBauhaus" e ícones otimizados.
> 4. **Layout do Latte Dock (**`~/.config/latte/NeuroLayout.layout.latte`**):**
>    * Cria um dock responsivo com organização eficiente de widgets, alinhado ao design neurovisual.
> 5. **Compositor (**`~/.config/kwincompositorrc`**):**
>    * Configura o backend de renderização (XRender), ajusta a taxa de quadros e reduz latência visual.
> 6. **Paleta de Cores (**`~/.local/share/color-schemes/NeuroBauhaus.colors`**):**
>    * Define um esquema de cores que melhora a percepção visual e reduz o esforço cognitivo.

**1.6 Pré-Carregamento Neural (Preload para Apps Frequentes)**

* **Ação:** Usar `preload` pra analisar seus hábitos e carregar bibliotecas de apps usados frequentemente na RAM antes de você abri-los.

{% code overflow="wrap" %}
```bash
sudo apt install -y preload
```
{% endcode %}

>
>
> * **Princípio Básico:** O preload utiliza algoritmos para monitorar os hábitos de uso do sistema. Ele analisa quais aplicativos e bibliotecas você acessa com frequência e prevê que serão usados novamente.
> * **Como Funciona:**
>   1. Ele roda em segundo plano como um daemon.
>   2. Utiliza estatísticas de acessos a arquivos (por exemplo, via `atime`).
>   3. Carrega bibliotecas e dependências diretamente na memória RAM antes de você abrir os aplicativos.
> * **Efeito:** Ao carregar recursos antecipadamente, o tempo de inicialização de programas é significativamente reduzido, porque não é necessário buscar tudo do disco rígido durante a abertura.
> * **Configuração:**
>   * Funciona automaticamente, mas pode ser personalizado para forçar a inclusão de aplicativos específicos no arquivo `/etc/preload.conf`.
>   * Exemplo: Você pode incluir apps como **Kate**, **Konsole**, **Dolphin** e **Firefox**, tornando-os mais rápidos para abrir.
>
> ***
>
>
>
> * **Interação com RAM e CPU:**
>   * O preload utiliza a **memória RAM** como um cache rápido para armazenar dados frequentemente acessados.
>   * Quando um aplicativo é aberto, a CPU busca primeiro na RAM para obter os dados, evitando leituras mais lentas do disco (HD ou SSD).
> * **Efeito no Hardware:**
>   * **Redução do uso do disco:** Minimiza acessos ao disco, o que é especialmente benéfico em discos rígidos mecânicos (HDD) que têm tempos de busca mais altos.
>   * **Aumento de eficiência:** Com mais operações ocorrendo na RAM, os processos tornam-se mais rápidos e eficientes.
> * **Pré-carregamento inteligente:** Aproveita o princípio da proximidade temporal no acesso a dados, diminuindo a latência percebida.

**1.7 Lobotomia no Indexador (Desabilitar Baloo)**

* **Ação:** Matar o Baloo, o indexador de arquivos do KDE, se você não usa a busca semântica dele. Economiza CPU e I/O pra caralho.
* O equivalente a desligar a parte do cérebro responsável por catalogar obsessivamente cada memória irrelevante. Foco no presente.
*   **Código:**&#x42;ash

    {% code overflow="wrap" %}
    ```sh
    balooctl disable
    balooctl purge # Limpa o índice antigo
    balooctl status # Confirma que tá desativado
    ```
    {% endcode %}

>
>
> * **Princípio Básico:** O Baloo é o indexador de arquivos usado pelo KDE para busca semântica, organizando todos os arquivos do sistema com base em seus conteúdos e atributos. Quando não é utilizado, ele pode consumir recursos desnecessários.
> * **Funcionamento:**
>   * Baloo opera como um serviço em segundo plano que monitora e indexa constantemente o sistema de arquivos.
>   * Ele utiliza **algoritmos de indexação** para catalogar informações sobre cada arquivo, o que requer uso intensivo de **CPU** e operações de entrada e saída (I/O).
> * **Impacto:** Em sistemas que não dependem de busca semântica, Baloo pode causar lentidão geral por:
>   * Ocupação excessiva de recursos do disco.
>   * Processamento contínuo no sistema.
>
> ***
>
> * **Interação com CPU e Disco:**
>   * Enquanto ativo, o Baloo realiza inúmeras operações de leitura e escrita no disco para criar e atualizar índices.
>   * Este uso intensivo de I/O pode levar a maior desgaste de discos mecânicos e aumentar o consumo de energia em sistemas portáteis.
> * **Desempenho após Desativação:**
>   * **Redução de consumo de CPU:** Sem o serviço rodando, o processador pode focar em tarefas realmente úteis, melhorando a eficiência geral.
>   * **Menor uso de disco:** Elimina acessos frequentes e repetitivos ao disco, o que reduz a latência e melhora a responsividade do sistema.
>   * **Economia de energia:** Ideal para laptops e dispositivos com hardware limitado, promovendo maior duração da bateria.



***


// ! Must ignore because of security.
class EnvironmentVariables {
  static const String urlETHClientDefault =
      'https://mainnet.infura.io/v3/60f4f885198c4cfab6de43b850c5e751';

  static const Map<String, String> urlETHClientMap = {
    'Mainnet': 'https://mainnet.infura.io/v3/60f4f885198c4cfab6de43b850c5e751',
    'Ropsten': 'https://ropsten.infura.io/v3/60f4f885198c4cfab6de43b850c5e751',
    'Kovan': 'https://kovan.infura.io/v3/60f4f885198c4cfab6de43b850c5e751',
    'Rinkeby': 'https://rinkeby.infura.io/v3/60f4f885198c4cfab6de43b850c5e751',
    'Goerli': 'https://goerli.infura.io/v3/60f4f885198c4cfab6de43b850c5e751',
  };
  static const Map<String, dynamic> listChainIDMap = {
    'Mainnet': 1,
    'Ropsten': 3,
    'Rinkeby': 4,
    'Goerli': 5,
    'Kovan': 42,
  };
  static const List<String> listNetwork = [
    'Mainnet',
    'Ropsten',
    'Rinkeby',
    'Goerli',
    'Kovan',
  ];
  // ! API Key Leak 👀
  static const apiKeyEtherScan = '47HTG6B1AZAJEQKUEW9RXP86QD7FBN4VZD';
}

const web3 = new Web3(Web3.givenProvider);

const contractAddress = 'YOUR_CONTRACT_ADDRESS'; // Replace with your actual contract address
const contractAbi = [
  // Replace with your contract ABI
];

const contractInstance = new web3.eth.Contract(contractAbi, contractAddress);

function createItem() {
  const itemname = $('#itemname').val();
  const brand = $('#brand').val();
  const exp = $('#exp').val();
  const cost = $('#cost').val();

  contractInstance.methods.Createitem(itemname, brand, exp, cost)
    .send({ from: web3.currentProvider.selectedAddress })
    .on('receipt', (receipt) => {
      console.log(receipt);
      updateLastItemId();
    });
}

function updateLastItemId() {
  contractInstance.methods.getLastItemId().call()
    .then(result => {
      $('#lastItemId').text(result);
    });
}

function checkProduct() {
  const productId = $('#checkProductId').val();
  contractInstance.methods.check(productId).call()
    .then(result => {
      const status = result ? 'Product exists' : 'Product does not exist';
      $('#checkResult').text(status);
    });
}

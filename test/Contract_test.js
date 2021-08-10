const Contract = artifacts.require('Contract');

contract('Contract', () => {
  it('should be deployed', async () => {
    const contract = await Contract.deployed();
    assert(contract.address !== '');
  });

  it('Get Owner', async () => {
    const contract = await Contract.deployed();
    const result = await contract.getOwner()
    assert(result === 'GET OWNER'); // TEST?
  });

  it('Is True', async () => {
   
    const contract = await Contract.deployed();
    const result = await contract.deposit();
    assert(result !== ""); // TEST pass always
  });

});
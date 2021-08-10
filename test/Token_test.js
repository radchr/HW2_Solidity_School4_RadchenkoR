const Token = artifacts.require('Token');

contract('Token', () => {
  it('should be deployed', async () => {
    const token = await Token.deployed();
    assert(token.address !== '');
  });
});
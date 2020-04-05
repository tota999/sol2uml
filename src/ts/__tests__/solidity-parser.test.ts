import parser from '@solidity-parser/parser'

describe('Solidity Parser', () => {
  test('pragma 0.5', () => {
    const node = parser.parse('pragma solidity 0.5;', {})
    expect(node).toBeDefined()
  });
  test('pragma ^0.5', () => {
    const node = parser.parse('pragma solidity ^0.5;', {})
    expect(node).toBeDefined()
  });
})

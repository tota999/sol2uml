import { ASTNode } from '@solidity-parser/parser';
import { UmlClass } from './umlClass';
export declare function convertNodeToUmlClass(node: ASTNode, codeSource: string): UmlClass[];

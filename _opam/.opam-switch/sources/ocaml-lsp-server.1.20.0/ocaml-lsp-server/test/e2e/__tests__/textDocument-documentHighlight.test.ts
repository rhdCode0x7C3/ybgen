import outdent from "outdent";
import * as LanguageServer from "../src/LanguageServer";
import * as Protocol from "vscode-languageserver-protocol";
import * as Types from "vscode-languageserver-types";

describe("textDocument/references", () => {
  let languageServer: LanguageServer.LanguageServer;

  function openDocument(source: string) {
    languageServer.sendNotification(
      Protocol.DidOpenTextDocumentNotification.type,
      {
        textDocument: Types.TextDocumentItem.create(
          "file:///test.ml",
          "ocaml",
          0,
          source,
        ),
      },
    );
  }

  async function query(position: Types.Position) {
    return await languageServer.sendRequest("textDocument/documentHighlight", {
      textDocument: Types.TextDocumentIdentifier.create("file:///test.ml"),
      position,
    });
  }

  beforeEach(async () => {
    languageServer = await LanguageServer.startAndInitialize();
  });

  afterEach(async () => {
    await LanguageServer.exit(languageServer);
  });

  it("highlight references in a file", async () => {
    openDocument(outdent`
      let num = 42
      let sum = num + 13
      let sum2 = sum + num
    `);

    let result = await query(Types.Position.create(0, 4));

    expect(result).toMatchInlineSnapshot(`
Array [
  Object {
    "kind": 1,
    "range": Object {
      "end": Object {
        "character": 7,
        "line": 0,
      },
      "start": Object {
        "character": 4,
        "line": 0,
      },
    },
  },
  Object {
    "kind": 1,
    "range": Object {
      "end": Object {
        "character": 13,
        "line": 1,
      },
      "start": Object {
        "character": 10,
        "line": 1,
      },
    },
  },
  Object {
    "kind": 1,
    "range": Object {
      "end": Object {
        "character": 20,
        "line": 2,
      },
      "start": Object {
        "character": 17,
        "line": 2,
      },
    },
  },
]
`);
  });
});

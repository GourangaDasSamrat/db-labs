// Bun bootstrap: shim v8 startupSnapshot, then load the app.
if (typeof globalThis.process?.getBuiltinModule === 'function') {
  const _orig = globalThis.process.getBuiltinModule.bind(globalThis.process);
  globalThis.process.getBuiltinModule = (name: string) => {
    if (name === 'v8') {
      return { startupSnapshot: { isBuildingSnapshot: () => false } };
    }
    try {
      return _orig(name);
    } catch (e) {
      return undefined as any;
    }
  };
  typeof globalThis.process.getBuiltinModule;
}

// Import the real app entrypoint
await import('./src/index.ts');
export {};

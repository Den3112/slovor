"use client";

import { useTheme } from "./providers/theme-provider";

export function ThemeToggle() {
  const { theme, toggle } = useTheme();

  return (
    <button
      type="button"
      onClick={toggle}
      className="rounded-full border border-slate-300 px-4 py-1 text-sm font-medium text-slate-700 transition hover:border-brand hover:text-brand dark:border-slate-600 dark:text-slate-200 dark:hover:border-brand-light dark:hover:text-brand-light"
      aria-label="Toggle theme"
    >
      {theme === "dark" ? "Dark" : "Light"}
    </button>
  );
}

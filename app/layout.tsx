import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "Herbal Medicine Visualizer",
  description: "Multi-dimensional visualization of herbal medicine data",
};

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode;
}>) {
  return (
    <html lang="en">
      <body>{children}</body>
    </html>
  );
}
